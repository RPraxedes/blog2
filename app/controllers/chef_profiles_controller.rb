class ChefProfilesController < ApplicationController
  before_action :find_chef, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :destroy, :update]

  def index
    @chef_profiles = ChefProfile.paginate(page: params[:page], per_page: 5)
  end

  def show
    @chef_recipes = @chef.chef_recipes.paginate(page: params[:page], per_page: 5)
  end

  def new
    @chef = ChefProfile.new
  end

  def create
    @chef = ChefProfile.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id  # to log in as soon as user has signed up
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

  def destroy
    @chef.destroy
    flash[:danger] = "Chef profile and associated recipes deleted successfully"
    redirect_to chef_profiles_path
  end

  private

  def find_chef
    @chef = ChefProfile.find(params[:id])
  end

  def chef_params
    params.require(:chef_profile).permit(:chefname, :email, :password, :password_confirmation)
  end

  def require_same_user
    if current_chef_profile != @chef_profile
      flash[:danger] = "You can only modify your own profile."
      redirect_to chef_profiles_path
    end
  end
end
