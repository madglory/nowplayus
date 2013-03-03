class HomeController < ApplicationController
  skip_before_filter :require_login
  layout 'home'

  def index
    redirect_to events_url if current_user
  end

  def contest
    render 'pages/contest', :layout => 'application'
 end
end