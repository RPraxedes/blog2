class ChefProfile < ApplicationRecord
  # chefname should be present
  # email should be present
  # size restrictions on email and chefname
  # email address should be a valid format
  # email should be unique, case insensitive
  # TDD - test driven development

  before_save { self.email = email.downcase }

  validates :chefname, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_many :chef_recipes, dependent: :destroy
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
  default_scope -> { order(chefname: :asc) }

  has_many :comments, dependent: :destroy
end
