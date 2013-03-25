class NotificationSetting < ActiveRecord::Base
  belongs_to :user
  attr_accessible :comment_via_direct_message, :comment_via_email, :participant_via_direct_message, :participant_via_email

  validates_presence_of :user
end