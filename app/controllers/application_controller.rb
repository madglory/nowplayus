class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login, except: :rescue_404
  before_filter :set_time_zone

  unless config.consider_all_requests_local || Rails.env != 'production'
    rescue_from Exception, with: :render_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::RoutingError, with: :render_not_found
    rescue_from ActionController::UnknownController, with: :render_not_found
    rescue_from AbstractController::ActionNotFound, with: :render_not_found
  end

  def rescue_404
    render_not_found
  end

private
  def set_time_zone
    Time.zone = current_user.time_zone if logged_in?
  end

  def not_authenticated
    redirect_to login_path, :alert => "Please login first."
  end

  def render_not_found(exception=nil)
    logger.error exception
    respond_to do |type|
      type.html { render template: "error_pages/404", layout: "application", status: "404 Not Found" }
      type.all  { render nothing: true, status: "404 Not Found" }
    end
  end

  def render_error(exception=nil)
    logger.error exception
    PartyFoul::RacklessExceptionHandler.handle(exception, params: exception.message)
    respond_to do |type|
      type.html { render template: "error_pages/500", layout: "application", status: "500 Internal Server Error" }
      type.all  { render nothing: true, status: "500 Internal Server Error" }
    end
  end
end
