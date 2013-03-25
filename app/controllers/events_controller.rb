class EventsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  before_filter :load_event, only: [:show]

  def index
    @events = Event.future

    respond_to do |format|
      format.html
      format.ics
      format.json { render json: [@user, @events] }
    end
  end

  def show
    @event_owner = (current_user == @event.host ? 'mine' : 'theirs')
    @comments = @event.comments.all
    @notification_subscription = current_user.notification_subscriptions.find_by_subscribable_id_and_subscribable_type(@event.id,'Event') if logged_in?

    respond_to do |format|
      format.html
      format.json { render json: [current_user, event] }
    end
  end

  def new
    @user = current_user
    @event = @user.hosted_events.new
    @event.notify_host = true

    respond_to do |format|
      format.html
      format.json { render json: @event }
    end
  end

  def create
    @event = current_user.hosted_events.new(params[:event])

    respond_to do |format|
      if @event.save
        Participant.create! user_id: current_user.id, event_id: @event.id, is_host: true
        format.html { redirect_to new_event_event_tweet_path(@event) }
        format.json { render json: @event, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    event = Event.find(params[:id])
    respond_to do |format|
      if event.host == current_user
        event.destroy
        format.html { redirect_to events_path, notice: 'Your event has been cancelled.' }
        format.json { render json: event, notice: 'Your event has been cancelled.' }
      else
        format.html { redirect_to events_path, alert: 'Not authorized!' }
        format.json { render json: event, alert: 'Not authorized!' }
      end
    end
  end
private
  def load_event
    @event = Event.find params[:id], include: :players
  end
end
