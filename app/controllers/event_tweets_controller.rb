class EventTweetsController < ApplicationController
  before_filter :require_login, :load_event

  def new
    @event_tweet = current_user.event_tweets.build event_id: @event.id
  end

  def create
    event_tweet = current_user.event_tweets.build params[:event_tweet].merge(event: @event)
    if event_tweet.save
      EventTweetsWorker.perform_async event_tweet.id
      redirect_to @event, notice: 'Tweet sent. Thanks!'
    else
      redirect_to @event, notice: 'Sorry, we were unable to send your tweet :('
    end
  end
private
  def load_event
    @event = Event.find params[:event_id]
  end
end