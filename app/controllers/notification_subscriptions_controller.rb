class NotificationSubscriptionsController < ApplicationController
  before_filter :require_login
  before_filter :load_subscribable_type, only: [:create]
  before_filter :load_subscribable_id, only: [:create]
  
  def create
    notification_subscription = NotificationSubscription.new user_id: current_user.id, subscribable_id: @subscribable_id, subscribable_type: @subscribable_type
    respond_to do |format|
      if notification_subscription.save
        format.html { redirect_to notification_subscription.subscribable, notice: "You will now receive notifications for this #{notification_subscription.subscribable_type.downcase}" }
        format.json { render json: notification_subscription, status: :created }
      else
        format.html { redirect_to notification_subscription.subscribable, alert: "Unable to subscribe to notifications" }
        format.json { render json: notification_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if params[:user_id_and_id]
      notification_subscription = NotificationSubscription.find_by_params params[:user_id_and_id]
    else
      notification_subscription = NotificationSubscription.find params[:id]
    end

    notification_subscription.destroy
    respond_to do |format|
      format.html { redirect_to notification_subscription.subscribable, notice: "You will no longer receive notifications for this #{notification_subscription.subscribable_type.downcase}" }
      format.json { head :no_content }
    end
  end

private
  def load_subscribable_id
    params[@subscribable_key]
  end

  def load_subscribable_type
    @subscribable_key.sub(/_id/, '').capitalize
  end

  def subscribable_key
    @subscribable_key ||= params.keys.keep_if { |key| key=~/_id/ }.first
  end
end