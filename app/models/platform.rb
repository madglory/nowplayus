class Platform < ActiveRecord::Base
  attr_accessible :name
  has_many :events

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
