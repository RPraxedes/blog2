class ChefRecipe < ApplicationRecord
  # recipe should be valid
  # name should be present
  # description should be present
  # chef_id should be present
  # maximum length for name and description, maybe a minimum for description

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  validates :chef_profile_id, presence: true

  belongs_to :chef_profile
end
