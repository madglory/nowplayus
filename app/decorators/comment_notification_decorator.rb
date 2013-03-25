class CommentNotificationDecorator < Decorators::Base
  def twitter_message
    "@#{actionable.user} just commented on #{actionable.commentable.truncate(50)} http://nowplay.us/comments/#{actionable.id}"
  end
end