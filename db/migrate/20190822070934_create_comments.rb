class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.integer :chef_profile_id
      t.integer :chef_recipe_id
      t.timestamps
    end
  end
end
