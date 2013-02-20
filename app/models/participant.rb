class Participant < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :is_host
  belongs_to :user
  belongs_to :host, class_name: 'User', conditions: "participants.is_host = true"
  belongs_to :player, class_name: 'User', conditions: "participants.is_host = false"
  belongs_to :event
end