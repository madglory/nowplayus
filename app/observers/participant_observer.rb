class ParticipantObserver < ActiveRecord::Observer
  def after_create(participant)
    # create a notification subscription for whoever joined
    NotificationSubscription.find_or_create_by_user_id_and_subscribable_type_and_subscribable_id participant.user_id, 'Event', participant.event_id
    return if participant.is_host
    event = participant.event
    return unless event.notify_host
    notification = NewParticipantNotification.create(participant_id: participant.user_id, event_id: participant.event_id)
    if notification.persisted?
      NewParticipantNotificationsWorker.perform_async notification.id
    end
  end
end