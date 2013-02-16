class PlatformAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :platform
  attr_accessible :username, :platform_id

  validates :user, presence: true
  validates_uniqueness_of :user_id, scope: :platform_id
  validates :platform, presence: true
  validates :username, presence: true
end
