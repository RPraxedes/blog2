require 'test_helper'

class ChefRecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "mail@example.com", password: "password", password_confirmation: "password")
    @recipe = ChefRecipe.create(name: "veg", description: "veggies", chef_profile_id: @chef.id)
    @recipe2 = @chef.chef_recipes.build(name: "chicken", description: "chicken")
    @recipe2.save
  end

  test "successfully delete a recipe" do
    get chef_recipe_path(@recipe)
    assert_template 'chef_recipes/show'
    assert_select 'a[href=?]', chef_recipe_path(@recipe), text: "Delete"
    assert_difference 'ChefRecipe.count', -1 do
      delete chef_recipe_path(@recipe)
    end
    assert_redirected_to chef_recipes_path
    assert_not flash.empty?
  end
end
