class EventsController < ApplicationController
  skip_before_filter :show, :index

  def index
    @user = User.find(params[:user_id])
    @events = @user.events_created

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [@user, @events] }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @event = @user.events_created.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: [@user, @event] }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = current_user
    @event = @user.events_created.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = current_user
    @event = @user.events_created.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to user_events_path(@user), notice: 'Event was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
