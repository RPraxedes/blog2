require 'test_helper'

class ChefProfilesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "mail@example.com", password: "password", password_confirmation: "password")
    @chef2 = ChefProfile.create(chefname: "name2", email: "mail2@example.com", password: "password", password_confirmation: "password")
    @admin = ChefProfile.create(chefname: "admin", email: "admin@example.com", password: "password", password_confirmation: "password", admin: true)
    @recipe = ChefRecipe.create(name: "veg", description: "veggies", chef_profile_id: @chef.id)
    @recipe2 = @chef.chef_recipes.build(name: "chicken", description: "chicken")
    @recipe2.save
  end

  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_profile_path(@chef)
    assert_template 'chef_profiles/edit'
    patch chef_profile_path(@chef), params: { chef_profile: { chefname: " ", email: "mail@example.com" } }
    assert_template 'chef_profiles/edit'
    assert_select 'p.alert-body'  # warning message
    assert_select 'div.alert'
  end

  test "accept a valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_profile_path(@chef)
    assert_template 'chef_profiles/edit'
    patch chef_profile_path(@chef), params: { chef_profile: { chefname: "Name1", email: "name2@example.com" } }
    assert_redirected_to @chef  # show page
    assert_not flash.empty?
    @chef.reload
    assert_match "Name1", @chef.chefname
    assert_match "name2@example.com", @chef.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin, "password")
    get edit_chef_profile_path(@chef)
    assert_template 'chef_profiles/edit'
    patch chef_profile_path(@chef), params: { chef_profile: { chefname: "Name3", email: "name3@example.com" } }
    assert_redirected_to @chef  # show page
    assert_not flash.empty?
    @chef.reload
    assert_match "Name3", @chef.chefname
    assert_match "name3@example.com", @chef.email
  end

  test "redirect edit attempt by another non-user" do
    sign_in_as(@chef2, "password")
    updated_name = "Jo"
    updated_email = "Taro@example.com"
    patch chef_profile_path(@chef), params: { chef_profile: { chefname: updated_name, email: updated_email } }
    assert_redirected_to chef_profiles_path  # index
    assert_not flash.empty?
    @chef.reload
    assert_match "name", @chef.chefname
    assert_match "mail@example.com", @chef.email
  end
end
