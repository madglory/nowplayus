class Clan < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :memberships
  has_many :users, through: :memberships
  attr_accessible :name
end
