class PlayersController < ApplicationController

  def join
    creator = User.find(params[:user_id])
    event = creator.events_created.find(params[:event_id])

    # find player
    # if not exists create it
    player = Player.find_by_event_id_and_user_id(event.id, current_user.id)
    unless player
      player = Player.new event_id: event.id, user_id: current_user.id

      player.save

      event.slots_filled += 1
      event.save

    end
    redirect_to user_event_path(creator, event)
  end

  def leave
    creator = User.find(params[:user_id])
    event = creator.events_created.find(params[:event_id])

    # find player
    # if exists destroy it
    player = Player.find_by_event_id_and_user_id(event.id, current_user.id)
    if player
      player.destroy
      event.slots_filled = event.slots_filled - 1
      event.save
    else
      # not playing!
    end
    redirect_to user_event_path(creator, @event)
  end
end
