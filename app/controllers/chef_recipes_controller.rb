class ChefRecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :destroy, :update]
  def index
    @recipes = ChefRecipe.all
  end

  def show
  end

  def new
    @recipe = ChefRecipe.new
  end

  def create
    @recipe = ChefRecipe.new(recipe_params)
    @recipe.chef_profile = ChefProfile.first  # no user auth yet
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

end
