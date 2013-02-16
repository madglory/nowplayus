class ParticipantsController < ApplicationController
  before_filter :require_login, :load_event, :load_host, :redirect_host

  def create
    # find participant
    # if not exists create it
    participant = Participant.find_or_create_by_event_id_and_user_id(@event.id, current_user.id)
    respond_to do |format|
      if participant
        format.html { redirect_to [@host, @event], notice: 'You joined the game!' }
        format.json { render json: participant, status: :created }
      else
        format.html { redirect_to [@host, @event], notice: 'Something went wrong' }
        format.json { render json: participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # find participant
    # if exists destroy it
    @participant = Participant.find_by_event_id_and_user_id(@event.id, current_user.id)
    respond_to do |format|
      if current_user_is_participant?
        @participant.destroy
        format.html { redirect_to [@host, @event], notice: 'You have left the game.' }
        format.json { render json: @participant, notice: 'You have left the game.' }
      else
        format.html { redirect_to current_user, notice: 'Not authorized!' }
        format.json { render json: {}, notice: 'Not authorized' }
      end
    end
  end

private
  def load_event
    @event = Event.find params[:event_id]
  end

  def load_host
    @host = @event.host
  end

  def redirect_host
    redirect_to user_event_path(current_user, @event) if current_user == @event.host
  end

  def current_user_is_participant?
    current_user == @participant.user
  end
end
