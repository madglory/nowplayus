class CommentsController < ApplicationController

  def create
    @event = Event.find params[:event_id]
    @comment = @event.comments.new params[:comment]
    @comment.user = current_user
    if @comment.save
      redirect_to @event
    end
  end

end
