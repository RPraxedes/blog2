class CreateChefUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :chef_users do |t|
      t.string :name
      t.string :email
    end
  end
end
