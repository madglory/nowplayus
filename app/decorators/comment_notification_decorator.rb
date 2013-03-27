class CommentNotificationDecorator < Decorators::Base

  def notification_subscription
    user.notification_subscriptions.find_by_subscribable_type_and_subscribable_id( commentable_type, commentable_id)
  end

  def twitter_message
    "@#{actionable.user} just commented on #{actionable.commentable.truncate(50)} http://nowplay.us/comments/#{actionable.id}"
  end

  def recipient
    user
  end

  def to_email
    recipient.email
  end

  def comment
    actionable
  end

  def comment_text
    comment.comment
  end

  def commenter
    actionable.user
  end

  def commentable
    comment.commentable
  end

  def commentable_type
    comment.commentable_type
  end

  def commentable_id
    comment.commentable_id
  end
end