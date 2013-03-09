class NotificationSubscription < ActiveRecord::Base
  attr_accessible :subscribable_id, :subscribable_type, :user_id
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  validates_presence_of :user, :subscribable
end
