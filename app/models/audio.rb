class Audio < ActiveRecord::Base

  acts_as_moderatable
  acts_as_voteable

  belongs_to :user
  belongs_to :audioable, :polymorphic => true
  belongs_to :source

  validates_format_of :url, :with => /\Ahttp(s?):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?\.mp3/i, :message => "should look like a URL ending in .mp3"

  before_save :set_user

  def set_user
    unless self.user.present? or self.audioable.nil?
      self.user = self.audioable.user if self.audioable.respond_to? :user
    end
    self.user = current_user unless self.user.present?
  end

  def default_title
    title.present? ? title : url
  end

end
