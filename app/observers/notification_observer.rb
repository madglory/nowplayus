class NotificationObserver < ActiveRecord::Observer
  def after_create(notification)
    NotificationWorker.perform_async(notification.id)
  end
end