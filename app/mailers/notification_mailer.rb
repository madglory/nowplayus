class NotificationMailer < ActionMailer::Base
  default from: 'notifier@nowplay.us'

  def comment_email(notification)
    @view = CommentNotificationDecorator.new notification
    
    mail(to: @view.to_email, subject: "New comment on #{@view.commentable}")
  end

  def participant_email(notification)
    @view = ParticipantNotificationDecorator.new notification
    
    mail(to: @view.to_email, subject: "#{@view.player} just joined the event for #{@view.title}")
  end 
end