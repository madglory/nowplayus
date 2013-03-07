class ParticipantObserver < ActiveRecord::Observer
  def after_create(participant)
    event = participant.event
    return unless event.notify_host
    notification = NewParticipantNotification.create(participant_id: participant.user_id, event_id: participant.event_id)
    if notification.persisted?
      NewParticipantNotificationsWorker.perform_async notification.id
    end
  end
end