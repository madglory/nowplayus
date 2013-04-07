class FollowsController < ApplicationController
  before_filter :require_login
  before_filter :load_followable
  
  def create
    current_user.follow! @followable
    respond_to do |format|
      format.html { redirect_to @followable, notice: "You are now following this #{notification_subscription.subscribable_type.downcase}" }
      format.json { render json: @followable, status: :created }
    end
  end

  def destroy
    current_user.unfollow! @followable
    respond_to do |format|
      format.html { redirect_to @followable, notice: "You are no longer following this #{notification_subscription.subscribable_type.downcase}" }
      format.json { head :no_content }
    end
  end

private
  def load_followable
    klass = fullpath[0].singularize.titleize.constantize
    @followable = klass.find(fullpath[1])
  end

  def fullpath
    request.fullpath.split('/').reject {|i| i.blank? }
  end
end