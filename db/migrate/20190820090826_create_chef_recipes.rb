class CreateChefRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :chef_recipes do |t|
      t.string :name
      t.text :description
      t.integer :chef_profile_id
    end
  end
end
