require 'test_helper'

class ChefRecipesText < ActionDispatch::IntegrationTest
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "mail@example.com")
    @recipe = ChefRecipe.create(name: "veg", description: "veggies")
    @recipe2 = @chef.chef_recipes.build(name: "chicken", description: "chicken")
    @recipe2.save
  end

  test "should get recipes index" do
    get chef_recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get chef_recipes_path
    assert_template 'chef_recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
