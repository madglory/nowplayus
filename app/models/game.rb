class Game < ActiveRecord::Base
  attr_accessible :name

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events

  def hashtag
    if self.read_attribute(:hashtag).nil?
      "##{self.slug.gsub(/-/,'')}"
    else
      self.read_attribute(:hashtag)
    end
  end

end
