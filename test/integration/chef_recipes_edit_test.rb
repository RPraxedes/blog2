require 'test_helper'

class ChefRecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "mail@example.com", password: "password", password_confirmation: "password")
    @recipe = ChefRecipe.create(name: "veg", description: "veggies", chef_profile_id: @chef.id)
    @recipe2 = @chef.chef_recipes.build(name: "chicken", description: "chicken")
    @recipe2.save
  end

  test "reject invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_chef_recipe_path(@recipe)
    assert_template 'chef_recipes/edit'
    patch chef_recipe_path(@recipe), params: { chef_recipe: { name: " ", description: "some description" } }
    assert_template 'chef_recipes/edit'
    assert_select 'p.alert-body'  # warning message
    assert_select 'div.alert'
  end

  test "successfully edit recipe" do
    sign_in_as(@chef, "password")
    get edit_chef_recipe_path(@recipe)
    assert_template 'chef_recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch chef_recipe_path(@recipe), params: { chef_recipe: { name: updated_name, description: updated_description } }
    assert_redirected_to @recipe    # same with follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end
end
