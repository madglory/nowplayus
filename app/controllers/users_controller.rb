class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show, :new, :create]
  before_filter :load_platforms, only: [:new, :edit, :update, :complete_registration, :confirm_registration]
  before_filter :load_user, only: [:show, :edit, :update, :destroy]
  before_filter :load_time_zones, only: [:edit, :update, :complete_registration]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @platform_accounts = @user.platform_accounts.includes :platform
    @events        = @user.events
    @future_events = @user.events.future(5)
    @past_events   = @user.events.past(4)

    respond_to do |format|
      format.html # show.html.erb
      format.ics  # show.ics.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @platform_accounts = @user.platform_accounts.includes :platform
    @notification_setting = @user.notification_setting
    unless @user == current_user
      redirect_to root_path, alert: "Not permitted"
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @platform_accounts = @user.platform_accounts.includes :platform
    @notification_setting = @user.notification_setting
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  def complete_registration
    @user = current_user
    @platform_accounts = @user.platform_accounts.includes :platform
  end

  def confirm_registration
    @user = current_user
    respond_to do |format|
      if @user.update_attributes params[:user]
        format.html { redirect_to @user, notice: 'Registration complete!' }
        format.json { head :no_content }
      else
        @platform_accounts = @user.platform_accounts.includes :platform
        format.html { render action: "complete_registration" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_password
    @user = current_user
  end

  def update_password
    @user = current_user
    respond_to do |format|
      if @user.update_attributes params[:user]
        format.html { redirect_to @user, notice: 'Password was successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: "change_password" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def load_platforms
    @platforms = Platform.select('id,name').all
  end

  def load_user
    @user = User.find params[:id].downcase
  end

  def load_time_zones
    @time_zones = ActiveSupport::TimeZone.us_zones
  end
end