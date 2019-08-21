class ChefProfilesController < ApplicationController
  def new
    @chef = ChefProfile.new
  end

  def create
    @chef = ChefProfile.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefname}!"
      redirect_to chef_profile_path(@chef)
    else
      render 'new'
    end
  end

  def show
  end

  private

  def find_chef
    @recipe = ChefRecipe.find(params[:id])
  end

  def chef_params
    params.require(:chef_profile).permit(:chefname, :email, :password, :password_confirmation)
  end
end
