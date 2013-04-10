class CommentsController < ApplicationController
  skip_before_filter :require_login, only: [:show]
  def create
    @event = Event.find params[:event_id]
    @comment = @event.comments.new params[:comment].merge(user_id: current_user.id)
    if @comment.save
      redirect_to @event
    end
  end

  def show
    comment = Comment.find params[:id]
    redirect_to comment.commentable, anchor: "comment-#{comment.id}"
  end
end