class ParticipantNotificationDecorator < Decorators::Base

  def notification_subscription
    user.notification_subscriptions.find_by_subscribable_type_and_subscribable_id('Event',event.id)
  end

  def twitter_message
    "@#{player} is in for #{short_title} http://nowplay.us/events/#{event.id}"
  end

  def scheduled_time_with_date
    event.starts_at.to_s(:date_time_long)
  end

  def short_title(chars = 50)
    event.to_s.truncate(chars)
  end

  def title
    event.to_s
  end

  def recipient
    user
  end

  def to_email
    recipient.email
  end

  def player
    actionable.user
  end

  def event
    actionable.event
  end
end