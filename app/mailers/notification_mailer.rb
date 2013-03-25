class NotificationMailer < ActionMailer::Base
  default from: 'notifier@nowplay.us'

  def comment_email(user, comment)
    @user = user
    @comment = comment
    @commentable = @comment.commentable
    mail(to: user.email, subject: "New comment on #{@commentable}")
  end

  def participant_email(user, participant)
    @user = user
    @participant = participant
    mail(to: user.email, subject: "#{@participant.user} just joined the event for #{@participant.event}")
  end 
end