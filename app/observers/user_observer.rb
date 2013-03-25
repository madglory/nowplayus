class UserObserver < ActiveRecord::Observer
  def after_create(user)
    user.notification_setting.create
  end
end