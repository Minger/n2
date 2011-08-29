require 'open-uri'
require 'timeout'

class Image < ActiveRecord::Base

  acts_as_moderatable
  acts_as_voteable
  acts_as_galleryable

  belongs_to :user
  belongs_to :imageable, :polymorphic => true
  belongs_to :source

  named_scope :newest, lambda { |*args| { :order => ["created_at desc"], :limit => (args.first || 8)} }
  named_scope :featured, lambda { |*args| { :conditions => ["is_featured=1"],:order => ["created_at desc"], :limit => (args.first || 3)} }

=begin
  has_attached_file :image,
    :styles => {
      :media_item => ["75x56#", :jpg],
      :thumb => ["100x75#", :jpg],
      :medium => ["320x240#", :jpg],
      :large => ["610x458#", :jpg]
    }
=end

  has_attached_file :image,
    :styles => {
      :media_item => ["75x56#", :jpg],
      :thumb => ["100x75#", :jpg],
      :medium => ["320x240#", :jpg],
      :large => ["610x458#", :jpg]
    },
    :storage => :s3,
    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
    :path => "/:attachment/:id/:style.jpg"
  validate :download_image, :if => :remote_image_url?
  validates_presence_of :image, :image_file_name, :image_content_type, :image_file_size

  before_save :set_user

  delegate :url, :to => :image

  def thumb_url
    url(:thumb)
  end

  def medium_url
    url(:medium)
  end

  def full_url
    url(:large)
  end

  def override_image?
    @override_image ||= false
  end

  def override_image= bool
    @override_image = !! bool
  end
  
  def expire
    self.class.sweeper.expire_image_all self
  end

  def self.sweeper
    ImageSweeper
  end

  def self.image_url? url
    url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?(jpg|jpeg|gif|png)([?;].*)?$/ix
  end

  private

  def set_user
    unless self.user.present? or self.imageable.nil?
      self.user = self.imageable.user if self.imageable.respond_to? :user
    end
  end

  def download_image
    return false unless remote_image_url_changed? or self.image_file_name.nil?
    errors.add(:remote_image_url, "image url must point to a jpeg, gif or png image url") and return unless override_image? or remote_image_url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?(jpg|jpeg|gif|png)([?;].*)?$/ix
    begin
      Timeout::timeout(10) {
        self.image = open(URI.parse(remote_image_url))
      }
    rescue Timeout::Error, OpenURI::HTTPError, Exception
      errors.add(:remote_image_url, "Could not download image. Please select another image.")
    end
  end

end
