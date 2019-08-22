class ChefRecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :destroy, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :destroy, :update]
  def index
    @chef_recipes = ChefRecipe.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @recipe = ChefRecipe.new
  end

  def create
    @recipe = ChefRecipe.new(recipe_params)
    @recipe.chef_profile = current_chef_profile
    if @recipe.save
        flash[:success] = "Your recipe was created successfully!"
        redirect_to chef_recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
        flash[:success] = "Your recipe was updated successfully!"
        redirect_to chef_recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deleted successfully"
    redirect_to chef_recipes_path
  end

  private

  def find_recipe
    @recipe = ChefRecipe.find(params[:id])
  end

  def recipe_params
    params.require(:chef_recipe).permit(:name, :description)
  end

  def require_same_user
    if current_chef_profile != @recipe.chef_profile
      flash[:danger] = "You can only modify your own recipes."
      redirect_to chef_recipes_path
    end
  end
end
