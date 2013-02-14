class PlatformAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :platform
  attr_accessible :username

  validates :user, presence: true
  validates :platform, presence: true
  validates :username, presence: true
end
