class CommentObserver < ActiveRecord::Observer
  attr_reader :comment

  def after_create(comment)
    @comment = comment
    # create a notification subscription for whatever was commented on
    create_notification_subscription!

    # notify all subscribed users except the one who commented
    create_notifications_for_subscribers!
  end
private
  def create_notification_subscription!
    NotificationSubscription.find_or_create_by_user_id_and_subscribable_type_and_subscribable_id comment.user_id, comment.commentable_type, comment.commentable_id
  end

  def create_notifications_for_subscribers!
    NotificationSubscription.select('user_id').where(["subscribable_type = ? AND subscribable_id = ? AND user_id != ?",comment.commentable_type, comment.commentable_id, comment.user_id]).each do |subscription|
      Notification.find_or_create_by_user_id_and_actionable_type_and_actionable_id(
        subscription.user_id,
        comment.class.to_s,
        comment.id)
    end
  end
end