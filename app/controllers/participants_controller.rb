class ParticipantsController < ApplicationController
  before_filter :require_login, :load_event, :load_host, :redirect_host

  def create
    # find participant
    # if not exists create it
    participant = Participant.find_or_create_by_event_id_and_user_id(@event.id, current_user.id)
    respond_to do |format|
      if participant
        # SEND NOTIFICATION IF HOST WANTS IT
        # I KNOW THERE IS A BETTER WAY OF DOING THIS BUT I'M DIRTY
        if @event.notify_host
          if notification = NewParticipantNotification.create(participant_id: current_user.id, event_id: @event.id)
            NewParticipantNotificationsWorker.perform_async notification.id
          end
        end

        format.html { redirect_to @event, notice: 'You joined the game!' }
        format.json { render json: participant, status: :created }
      else
        format.html { redirect_to @event, alert: 'Something went wrong' }
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
        format.html { redirect_to @event, notice: 'You have left the game.' }
        format.json { render json: @participant, notice: 'You have left the game.' }
      else
        format.html { redirect_to current_user, alert: 'Not authorized!' }
        format.json { render json: {}, alert: 'Not authorized' }
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
    redirect_to event_path(@event) if current_user == @event.host
  end

  def current_user_is_participant?
    current_user == @participant.user
  end
end
