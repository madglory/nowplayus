class EventTweet < ActiveRecord::Base
  include Rails.application.routes.url_helpers
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
    if event.past?
      "Joined @#{event.host_name} and others for a game of #{event.title} via @nowplayus #{event_url(event)} #{event.platform_hashtag} #{event.game_hashtag}"
    else
      "Join me, @#{event.host_name} and others for a game of #{event.title} via @nowplayus #{event_url(event)} #{event.platform_hashtag} #{event.game_hashtag}"
    end
  end

  def default_host_status
    if event.past?
      "Played a game of #{event.title} via @nowplayus #{event_url(event)} #{event.platform_hashtag} #{event.game_hashtag}"
    else
      "Join me for a game of #{event.title} via @nowplayus #{event_url(event)} #{event.platform_hashtag} #{event.game_hashtag}"
    end
  end
end