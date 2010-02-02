class IdeaBoard < ActiveRecord::Base
  acts_as_taggable_on :tags

  has_many :ideas

  has_friendly_id :name, :use_slug => true, :reserved => RESERVED_NAMES
  validates_presence_of :name, :section, :description

  def to_s
    "Idea Board: #{name}"
  end

end
