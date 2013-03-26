class NotificationSubscription < ActiveRecord::Base
  attr_accessible :subscribable_id, :subscribable_type, :user_id
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  validates_presence_of :user, :subscribable

  def self.find_by_param(param)
    user_id, id = param.split('-')
    find_by_user_id_and_id(user_id, id)
  end

  def to_param
    "#{user_id}-#{id}"
  end
end