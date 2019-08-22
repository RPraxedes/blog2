require 'test_helper'

class ChefRecipesText < ActionDispatch::IntegrationTest
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "mail@example.com", password: "password", password_confirmation: "password")
    @recipe = ChefRecipe.create(name: "veg", description: "veggies", chef_profile_id: @chef.id)
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
    assert_select "a[href=?]", chef_recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", chef_recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes show" do
    sign_in_as(@chef, "password")
    get chef_recipe_path(@recipe)
    assert_template 'chef_recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
    assert_select "a[href=?]", edit_chef_recipe_path(@recipe), text: "Edit"
    assert_select "a[href=?]", chef_recipe_path(@recipe), text: "Delete"
  end

  test "create new valid recipe" do
    sign_in_as(@chef, "password")
    get new_chef_recipe_path
    assert_template 'chef_recipes/new'
    name_of_recipe = "Chicken"
    description_of_recipe = "Just raw chicken"
    assert_difference 'ChefRecipe.count', 1 do
      post chef_recipes_path, params: { chef_recipe: {name: name_of_recipe, description: description_of_recipe} }
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject new invalid recipes" do
    sign_in_as(@chef, "password")
    get new_chef_recipe_path
    assert_template 'chef_recipes/new'
    assert_no_difference 'ChefRecipe.count' do
      post chef_recipes_path, params: { chef_recipe: {name: " ", description: " "} }
    end
    assert_template 'chef_recipes/new'
    assert_select 'p.alert-body'  # warning message
    assert_select 'div.alert'
  end
end
