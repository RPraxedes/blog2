require 'test_helper'

class ChefProfilesShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "mail@example.com", password: "password", password_confirmation: "password")
    @recipe = ChefRecipe.create(name: "veg", description: "veggies", chef_profile_id: @chef.id)
    @recipe2 = @chef.chef_recipes.build(name: "chicken", description: "chicken")
    @recipe2.save
  end

  test "should get chef profiles show" do
    get chef_profile_path(@chef)
    assert_template 'chef_profiles/show'
    assert_select "a[href=?]", chef_recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", chef_recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end
end
