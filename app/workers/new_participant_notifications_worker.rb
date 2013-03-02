class NewParticipantNotificationsWorker
  include Sidekiq::Worker

  def perform(notification_id)
    notification = NewParticipantNotification.find notification_id
    if TwitterNotificationSender.send!(notification)
      notification.set_as_sent!
    end
  end
end