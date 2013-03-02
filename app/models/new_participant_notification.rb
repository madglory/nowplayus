class NewParticipantNotification < ActiveRecord::Base
  attr_accessible :participant_id, :event_id
  
  belongs_to :event
  belongs_to :participant, class_name: 'User'

  before_validation :set_message

  validates_presence_of :event, :participant, :message
  validates_length_of :message, maximum: 140, minimum: 1
  validates_uniqueness_of :message, scope: [ :event_id, :participant_id ]

  def user
    event.host
  end

  def set_as_sent!
    update_attribute :sent, true
  end

private
  def default_message
    "#{participant.platform_username(event.platform)} is in for #{event.title.truncate(50)} http://nowplay.us/events/#{event.id}"
  end

  def set_message
    self.message = default_message
  end
end