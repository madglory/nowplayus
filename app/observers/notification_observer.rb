class NotificationObserver < ActiveRecord::Observer
  def after_create(notification)
    NotificationWorker.perform_in 15.seconds, notification.id
  end
end