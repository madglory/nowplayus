class Clan < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  attr_accessible :name
end
