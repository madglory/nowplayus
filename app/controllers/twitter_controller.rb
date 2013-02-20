class TwitterController < ApplicationController
  before_filter :require_login, :load_event

  def update
    message = current_user == @event.host ? default_host_message : default_player_message
    Tweet.send! current_user, message
    redirect_to :back, notice: 'Tweet sent!'
  end
private
  def load_event
    @event = Event.find params[:event_id]
  end

  def default_player_message
    "Join me, @#{@event.host_name} and #{@event.player_count - 1} others for a game of #{@event.title} http://nowplay.us/events/#{@event.id} via @nowplayus ##{@event.platform_name.gsub(/\s/,'')}"
  end

  def default_host_message
    "Join me for a game of #{@event.title} http://nowplay.us/events/#{@event.id} via @nowplayus ##{@event.platform_name.gsub(/\s/,'')}"
  end
end