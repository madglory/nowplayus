class Platform < ActiveRecord::Base
  attr_accessible :name, :giantbomb_id
  has_many :events

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
