class ChefRecipesController < ApplicationController
  def index
    @recipes = ChefRecipe.all
  end
end
