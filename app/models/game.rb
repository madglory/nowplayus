class Game < ActiveRecord::Base
  extend FriendlyId

  # attr_accessible :title, :body
  friendly_id :name, use: :slugged

  has_many :events

end
