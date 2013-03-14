class Clan < ActiveRecord::Base
  has_many :users, through: :memberships
  attr_accessible :name
end
