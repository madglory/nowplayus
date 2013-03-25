class NotificationDirectMessage
  def self.comment_direct_message(notificaiton)
    message = CommentNotificationDecorator.new(notification).twitter_message
    DirectMessage.new(user, message)
  end

  def self.participant_direct_message(notification)
    message = ParticipantNotificationDecorator.new(notification).twitter_message
    DirectMessage.new(notification.user, message)
  end
end