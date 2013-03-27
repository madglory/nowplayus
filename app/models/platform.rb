class Platform < ActiveRecord::Base
  attr_accessible :name, :giantbomb_id
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def icon
    "#{slug}.png"
  end
end
