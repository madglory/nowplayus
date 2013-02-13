class EventsController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @events = (@user.events_created + @user.events).sort { |a,b| b.starts_at <=> a.starts_at }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [@user, @events] }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @event = @user.events_created.find(params[:id], include: :players)
    @event_owner = (current_user == @event.user ? 'mine' : 'theirs')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [current_user, event] }
    end
  end

  def new
    @user = current_user
    @event = @user.events_created.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def create
    event = current_user.events_created.new(params[:event])

    respond_to do |format|
      if event.save
        format.html { redirect_to user_events_path(current_user), notice: 'Event was successfully created.' }
        format.json { render json: event, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    event = Event.find(params[:id])
    respond_to do |format|
      if event.user == current_user
        event.destroy
        format.html { redirect_to user_events_path(current_user), notice: 'Your event has been cancelled.' }
        format.json { render json: event, notice: 'Your event has been cancelled.' }
      else
        format.html { redirect_to user_events_path(current_user), notice: 'Not authorized!' }
        format.json { render json: event, notice: 'Not authorized!' }
      end
    end
  end
end
