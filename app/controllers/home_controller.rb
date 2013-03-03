class HomeController < ApplicationController
  skip_before_filter :require_login, :only => [:index]
  layout 'home'

  def index
    # redirect_to event_path if current_user
  end
end