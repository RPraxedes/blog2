class ChefRecipesController < ApplicationController
  def index
    @recipes = ChefRecipe.all
  end

  def show
    @recipe = ChefRecipe.find(params[:id])
  end

  def new
    @recipe = ChefRecipe.new
  end

  def create
    @recipe = ChefRecipe.new(recipe_params)
    @recipe.chef_profile = ChefProfile.first  # no user auth yet
    if @recipe.save
        flash[:success] = "Recipe was created successfully!"
        redirect_to chef_recipe_path(@recipe)
    else
      render 'new'
    end
  end

  private

  def recipe_params
    params.require(:chef_recipe).permit(:name, :description)
  end

end
