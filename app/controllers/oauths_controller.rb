class OauthsController < ApplicationController
  skip_before_filter :require_login
      
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end
      
  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      if @user.registration_complete?
        redirect_back_or_to root_path, notice: "Logged in from #{provider.titleize}!"
      else
        redirect_to edit_user_path(@user), notice: 'Please complete your registration!'
      end
    else
      begin
        @user = create_from(provider)
        @user.save validate: false # get slug w/o triggering (on: :update) validation on :email

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to edit_user_path(@user), notice: "Please complete your registration!"
      rescue
        redirect_back_or_to root_path, alert: "Failed to login from #{provider.titleize}!"
      end
    end
  end
end
