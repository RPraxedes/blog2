class CreateChefProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :chef_profiles do |t|
      t.string :chefname
      t.string :email
    end
  end
end
