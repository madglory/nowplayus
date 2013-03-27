class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  attr_reader :actionable_type, :actionable, :notification, :notification_setting, :user, :types

  def perform(id)
    @notification = Notification.find id
    @user = notification.user
    @notification_setting = user.notification_setting
    @actionable = notification.actionable
    @actionable_type = notification.actionable_type.downcase
    @types = {
      :email => "#{actionable_type}_via_email",
      :direct_message => "#{actionable_type}_via_direct_message" }

    types.each do |type, setting|
      send(type) if notification_setting.send(setting)
    end
  end

private
  def email
    NotificationMailer.send("#{actionable_type}_email", notification).deliver
  end

  def direct_message
    NotificationDirectMessage.send("#{actionable_type}_direct_message", notification).deliver
  end
end