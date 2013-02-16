class PlatformAccounts < ApplicationController
  before_filter :require_login, :load_user, :load_platform

  def new
    @platform_account = @user.platform_accounts.new
  end

  def create
    @platform_account = PlatformAccount.new user_id: @user.id, platform_id: @platform.id, username: params[:username]
    respond_to do |format|
      if @platform_account.save
        format.html { redirect_to @user, notice: 'Platform Account was successfully created.' }
        format.json { render json: @platform_account, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @platform_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    platform_account = PlatformAccount.find_by_user_id_and_platform_id params[:user_id], params[:platform_id]
    respond_to do |format|
      if current_user_owns_platform_account?
        platform_account.destroy
        format.html { redirect_to current_user, notice: 'Your Platform Account has been deleted.' }
        format.json { render json: platform_account, notice: 'Platform Account has been destroyed.' }
      else
        format.html { redirect_to current_user, notice: 'Not authorized!' }
        format.json { render json: {}, notice: 'Not authorized!' }
      end
    end
  end

private
  def load_user
    @user = User.find params[:user_id]
  end

  def load_platform
    @platform = Platform.find params[:platform_id]
  end

  def current_user_owns_platform_account?
    current_user == @platform_account.user
  end
end