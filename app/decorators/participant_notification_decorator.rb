class ParticipantNotificationDecorator < Decorators::Base

  def twitter_message
    "@#{actionable.user} is in for #{actionable.event.to_s.truncate(50)} http://nowplay.us/events/#{actionable.event.id}"
  end
end