class Comment < ApplicationRecord
  validates :description, presence: true, length: { minimum: 4, maximum: 140 }
  belongs_to :chef_profile
  belongs_to :chef_recipe
  validates :chef_recipe_id, presence: true
  validates :chef_recipe_id, presence: true
  default_scope -> { order(updated_at: :desc) }
end
