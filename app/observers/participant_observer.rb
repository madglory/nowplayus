class ParticipantObserver < ActiveRecord::Observer
  attr_reader :participant

  def after_create(participant)
    @participant = participant
    create_notification_subscription!
    create_notifications_for_subscribers!
  end
private
  def create_notification_subscription!
    NotificationSubscription.find_or_create_by_user_id_and_subscribable_type_and_subscribable_id participant.user_id, 'Event', participant.event_id
  end

  def create_notifications_for_subscribers!
    NotificationSubscription.select('user_id').where(["subscribable_type = ? AND subscribable_id = ? AND user_id != ?",'Event', participant.event_id, participant.user_id]).each do |subscription|
      Notification.find_or_create_by_user_id_and_actionable_type_and_actionable_id(
        subscription.user_id,
        'Participant',
        participant.id)
    end
  end
end