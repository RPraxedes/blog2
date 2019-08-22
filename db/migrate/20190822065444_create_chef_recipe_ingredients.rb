class CreateChefRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :chef_recipe_ingredients do |t|
      t.integer :chef_recipe_id
      t.integer :ingredient_id
    end
  end
end
