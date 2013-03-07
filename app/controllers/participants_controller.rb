class ParticipantsController < ApplicationController
  before_filter :require_login, :load_event, :load_host, :redirect_host

  def create
    participant = Participant.new event_id: @event.id, user_id: current_user.id
    respond_to do |format|
      if participant.save
        format.html { redirect_to @event, notice: 'You joined the game!' }
        format.json { render json: participant, status: :created }
      else
        format.html { redirect_to @event, alert: 'Something went wrong' }
        format.json { render json: participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    participant = Participant.find_by_event_id_and_user_id(@event.id, current_user.id)
    participant.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'You have left the game.' }
      format.json { head :no_content }
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
end
