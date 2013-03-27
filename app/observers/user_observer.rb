class UserObserver < ActiveRecord::Observer
  def after_create(user)
    user.create_notification_setting
  end
end