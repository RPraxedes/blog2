require 'test_helper'

class ChefProfilesListingTest < ActionDispatch::IntegrationTest
  def setup
    @chef = ChefProfile.create(chefname: "name", email: "mail@example.com", password: "password", password_confirmation: "password")
    @chef2 = ChefProfile.create(chefname: "name2", email: "mail2@example.com", password: "password", password_confirmation: "password")
    @admin = ChefProfile.create(chefname: "admin", email: "admin@example.com", password: "password", password_confirmation: "password", admin: true)
  end

  test "should get chef profiles listing" do
    sign_in_as(@chef, "password")
    get chef_profiles_path
    assert_template 'chef_profiles/index'
    assert_select "a[href=?]", chef_profile_path(@chef), text: "View Profile"
    assert_select "a[href=?]", chef_profile_path(@chef2), text: "View Profile"
  end

  test "should delete chef" do
    sign_in_as(@admin, "password")
    get chef_profiles_path
    assert_template 'chef_profiles/index'
    assert_difference 'ChefProfile.count', -1 do
      delete chef_profile_path(@chef2)
    end
    assert_redirected_to chef_profiles_path
    assert_not flash.empty?
  end
end
