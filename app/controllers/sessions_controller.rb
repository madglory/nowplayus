class SessionsController < ApplicationController
  before_filter :require_login, only: [:destroy]
  
  def create
    if authentication = Authentication.find_from_hash(auth_hash)
      authentication.update_tokens_from_hash(auth_hash)
    else
      authentication = Authentication.create_from_hash(auth_hash)
    end
    
    user = authentication.user
    original_path = origin

    # protect from session fixation attack
    reset_session
    # login via sorcery
    auto_login(user)

    if user.registration_complete?
      redirect_to original_path || root_path, notice: 'Logged in!'
    else
      redirect_to complete_registration_path, notice: 'Please complete your registration.'
    end
  end
    
  def destroy
    logout
    redirect_to root_path, notice: 'Logged out!'
  end

private
  def auth_hash
    request.env['omniauth.auth']
  end

  def origin
    request.env['omniauth.origin']
  end
end