require 'test_helper'

class ChefRecipesTest < ActiveSupport::TestCase
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "name@example.com", password: "password", password_confirmation: "password")
    @recipe = @chef.chef_recipes.build(name: "Veg", description: "Description")
  end

  test "recipe without chef should be invalid" do
    @recipe.chef_profile_id = nil
    assert_not @recipe.valid?
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description should not be less than 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end

  test "description should not be more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
end
