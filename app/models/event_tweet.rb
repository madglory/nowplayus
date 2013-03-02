class EventTweet < ActiveRecord::Base
  attr_accessible :status, :user, :event
  after_initialize :default_status

  belongs_to :user
  belongs_to :event

  validates_presence_of :user, :status, :event
  validates_length_of :status, maximum: 140, minimum: 1
  validates_uniqueness_of :status, scope: [ :event_id, :user_id ]

  def set_as_sent!
    update_attribute :sent, true
  end

private

  def default_status
    self.status ||= (event.host == user ? default_host_status : default_player_status)
  end

  def default_player_status
    "Join me, @#{event.host_name} and #{event.total_players - 1} others for a game of #{event.title} via @nowplayus http://nowplay.us/events/#{event.id} ##{event.platform_name.gsub(/\s/,'')}"
  end

  def default_host_status
    "Join me for a game of #{event.title} via @nowplayus http://nowplay.us/events/#{event.id} ##{event.platform_name.gsub(/\s/,'')}"
  end
end