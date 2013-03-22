class HomeController < ApplicationController
  skip_before_filter :require_login

  def index
    redirect_to events_url if current_user
  end

  def contest
  end
end