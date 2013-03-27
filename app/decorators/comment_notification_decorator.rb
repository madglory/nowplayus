class CommentNotificationDecorator < Decorators::Base

  def notification_subscription
    user.notification_subscriptions.find_by_subscribable_type_and_subscribable_id( commentable_type, commentable_id)
  end

  def twitter_message
    "@#{commenter} just commented on #{commentable.to_s.truncate(50)} #{comment_url(comment)}?t=#{Time.now.to_i}"
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