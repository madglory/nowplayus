class TweetsController < ApplicationController
  before_filter :require_login, :load_event

  def new
    @tweet = Tweet.new event: @event, user: current_user
  end

  def create
    @tweet = Tweet.new params[:tweet].merge(event: @event, user: current_user)
    if @tweet.valid?
      # HANDLE ERRORS GRACEFULLY
      # DOING IT THIS WAY FOR NOW UNTIL WE CAN START PUTTING STUFF IN A QUEUE
      begin
        TweetSender.send_tweet @tweet
      rescue => exception
        logger.error exception
        PartyFoul::ExceptionHandler.handle(exception,env) if Rails.env == 'production'
        redirect_to :back, alert: 'Sorry, we are unable to send your tweet at this time :('
      else
        redirect_to :back, notice: 'Tweet sent. Thanks!'
      end
    else
      render action: 'new'
    end
  end
private
  def load_event
    @event = Event.find params[:event_id]
  end
end