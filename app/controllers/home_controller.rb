class HomeController < ApplicationController
  skip_before_filter :require_login, :only => [:index]
  layout 'home'

  def index
    @events = Event.future(5)
  end

end
