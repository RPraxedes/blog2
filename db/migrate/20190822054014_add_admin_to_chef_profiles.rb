class AddAdminToChefProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :chef_profiles, :admin, :boolean, default: :false
  end
end
