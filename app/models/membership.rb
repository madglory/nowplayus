class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :clan

  validates_uniqueness_of :user_id, scope: [:clan_id]
end