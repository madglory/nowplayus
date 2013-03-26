class NotificationSettingsController < ApplicationController
  before_filter :require_login

  def edit
    @notificaiton_setting = current_user.notification_setting
  end

  def update
    @notification_setting = current_user.notification_setting
    respond_to do |format|
      if @notification_setting.update_attributes(params[:notification_setting])
        format.html { redirect_to current_user, notice: 'Notification settings were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification_setting.errors, status: :unprocessable_entity }
      end
    end
  end
end