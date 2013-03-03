class Game < ActiveRecord::Base
  attr_accessible :name

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events

end
