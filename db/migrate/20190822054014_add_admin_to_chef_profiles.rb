class AddAdminToChefProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :chef_profiles, :admin, :boolean, default: :false
    # chef_profile.toggle!(:admin) ==> false -> true
  end
end
