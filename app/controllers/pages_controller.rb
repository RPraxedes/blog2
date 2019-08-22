class PagesController < ApplicationController
  def homepage
    redirect_to chef_recipes_path if logged_in?
  end
end
