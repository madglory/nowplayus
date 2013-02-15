class ParticipantsController < ApplicationController
  before_filter :require_login, :load_event, :load_host, :redirect_host

  def join
    # find player
    # if not exists create it
    player = Participant.find_by_event_id_and_user_id(@event.id, current_user.id)
    unless player
      player = Participant.new event_id: @event.id, user_id: current_user.id
      player.save
    end
    redirect_to user_event_path(@host, @event)
  end

  def leave
    # find participant
    # if exists destroy it
    participant = Participant.find_by_event_id_and_user_id(@event.id, current_user.id)
    
    participant.destroy if participant

    redirect_to user_event_path(@host, @event)
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
end
