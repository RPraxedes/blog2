class Ingredient < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name

  has_many :chef_recipe_ingredients
  has_many :chef_recipes, through: :chef_recipe_ingredients
end
