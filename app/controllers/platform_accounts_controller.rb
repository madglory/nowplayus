class PlatformAccounts < ApplicationController
  before_filter :require_login, :load_user, :load_platform

  def create

  end

  def destroy

  end

private
  def load_user
    @user = User.find params[:user_id]
  end

  def load_platform
    @platform = Platform.find params[:platform_id]
  end
end