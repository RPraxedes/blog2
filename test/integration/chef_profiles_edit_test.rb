require 'test_helper'

class ChefProfilesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "mail@example.com", password: "password", password_confirmation: "password")
    @recipe = ChefRecipe.create(name: "veg", description: "veggies", chef_profile_id: @chef.id)
    @recipe2 = @chef.chef_recipes.build(name: "chicken", description: "chicken")
    @recipe2.save
  end

  test "reject an invalid edit" do
    get edit_chef_profile_path(@chef)
    assert_template 'chef_profiles/edit'
    patch chef_profile_path(@chef), params: { chef_profile: { chefname: " ", email: "mail@example.com" } }
    assert_template 'chef_profiles/edit'
    assert_select 'p.alert-body'  # warning message
    assert_select 'div.alert'
  end

  test "accept a valid edit" do
    get edit_chef_profile_path(@chef)
    assert_template 'chef_profiles/edit'
    patch chef_profile_path(@chef), params: { chef_profile: { chefname: "Name1", email: "name2@example.com" } }
    assert_redirected_to @chef  # show page
    assert_not flash.empty?
    @chef.reload
    assert_match "Name1", @chef.chefname
    assert_match "name2@example.com", @chef.email
  end
end
