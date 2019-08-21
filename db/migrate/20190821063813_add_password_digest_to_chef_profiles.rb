class AddPasswordDigestToChefProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :chef_profiles, :password_digest, :string
  end
end
