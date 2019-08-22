class ApplicationController < ActionController::Base

  helper_method :current_chef_profile, :logged_in?

  def current_chef_profile
    @current_chef_profile ||= ChefProfile.find(session[:chef_id]) if session[:chef_id]
  end

  def logged_in?
    !!current_chef_profile  # changes to true or false
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to root_path
    end
  end
end
