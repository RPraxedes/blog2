class SessionsController < ApplicationController
  # make login form
  def new; end

  def create  # create session
    chef = ChefProfile.find_by( email: params[:session][:email].downcase )
    if chef && chef.authenticate( params[:session][:password] )
      session[:chef_id] = chef.id
      flash[:success] = "Login successful!"
      redirect_to chef
    else
      flash.now[:danger] = "There was an error logging in."
      render 'new'
    end
  end

  def destroy # destroy session
    session[:chef_id] = nil
    flash[:success] = "You have logged out!"
    redirect_to root_path
    end
end
