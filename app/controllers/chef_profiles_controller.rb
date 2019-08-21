class ChefProfilesController < ApplicationController
  before_action :find_chef, only: [:show, :edit, :update, :destroy]

  def show; end

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

  def edit; end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to @chef   # short for chef_profile_path(@chef)
    else
      render 'edit'
    end
  end

  private

  def find_chef
    @chef = ChefProfile.find(params[:id])
  end

  def chef_params
    params.require(:chef_profile).permit(:chefname, :email, :password, :password_confirmation)
  end
end
