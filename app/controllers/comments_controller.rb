class CommentsController < ApplicationController
  def create
    @event = Event.find params[:event_id]
    @comment = @event.comments.new params[:comment].merge(user_id: current_user.id)
    if @comment.save
      redirect_to @event
    end
  end
end