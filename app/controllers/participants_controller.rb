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

  def join_bench

    # event must not have open slots
    # user must not already be playing
    participant = Participant.find_or_create_by_event_id_and_user_id @event.id, current_user.id

  end

  def leave
    host = User.find(params[:user_id])
    event = host.events_created.find(params[:event_id])

    # find participant
    # if exists destroy it
    participant = Participant.find_by_event_id_and_user_id(event.id, current_user.id)
    if participant
      participant.destroy
      event.slots_filled = event.slots_filled - 1
      event.save
    else
      # not playing!
    end
    redirect_to user_event_path(host, event)
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
