class ChefRecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :chef_recipe
end
