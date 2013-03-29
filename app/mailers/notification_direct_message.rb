class NotificationDirectMessage
  def self.comment_direct_message(notification)
    view = CommentNotificationDecorator.new(notification)
    DirectMessage.new(notification.user, view.twitter_message)
  end

  def self.participant_direct_message(notification)
    view = ParticipantNotificationDecorator.new(notification)
    DirectMessage.new(notification.user, view.twitter_message)
  end
end