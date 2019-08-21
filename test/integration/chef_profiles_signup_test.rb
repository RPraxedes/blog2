require 'test_helper'

class ChefProfilesSignupTest < ActionDispatch::IntegrationTest
  test "should get signup path" do
    get signup_path
    assert_response :success
  end

  test "reject an invalid signup" do
    get signup_path
    assert_no_difference "ChefProfile.count" do
      post chef_profiles_path, params: { chef_profile: { chefname: " ", email: " ", password: "password", password_confirmation: " " } }
    end
    assert_template 'chef_profiles/new'
    assert_select 'p.alert-body'  # warning message
    assert_select 'div.alert'
  end

  test "accept valid signup" do
    get signup_path
    assert_difference "ChefProfile.count", 1 do
      post chef_profiles_path, params: { chef_profile: { chefname: "Name1", email: "mail@example.org", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'chef_profiles/show'
    assert_not flash.empty?
  end
end
