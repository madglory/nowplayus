class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    # create a notification subscription for whatever was commented on
    NotificationSubscription.find_or_create_by_user_id_and_subscribable_type_and_subscribable_id comment.user_id, comment.commentable_type, comment.commentable_id
  end
end