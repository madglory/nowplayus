class HomeController < ApplicationController
  skip_before_filter :require_login, :only => [:index]

  def index
    @events = Event.all(:limit => 5)
  end

end
