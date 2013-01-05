class PlayersController < ApplicationController

  def join
    @creator = User.find(params[:user_id])
    @event = @creator.events_created.find(params[:event_id])
    @user = current_user

    # find player
    # if not exists create it
    @player = Player.find_by_event_id_and_user_id(@event.id, @user.id)
    if @player
      # already playing!
    else
      @player = Player.new
      @player.user = @user
      @player.event = @event

      @player.save

      @event.slots_filled = @event.slots_filled + 1
      @event.save

    end
    redirect_to user_event_path(@creator, @event)
  end

  def leave
    @creator = User.find(params[:user_id])
    @event = @creator.events_created.find(params[:event_id])
    @user = current_user

    # find player
    # if exists destroy it
    @player = Player.find_by_event_id_and_user_id(@event.id, @user.id)
    if @player
      @player.destroy
      @event.slots_filled = @event.slots_filled - 1
      @event.save
    else
      # not playing!
    end
    redirect_to user_event_path(@creator, @event)
  end
end
