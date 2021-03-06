require 'test_helper'

class ChefProfileTest < ActiveSupport::TestCase

  def setup
     @chef = ChefProfile.new(chefname: "Name", email: "mail@example.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should not be more than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end

  test "email should not be more than 255 characters" do
    @chef.email = "b" * 246 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should accept correct format" do
    valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid!"
    end
  end

  test "should reject invalid addresses" do
    invalid_emails = %w[mashrur@example rashrur@example,com mashrur.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid!"
    end
  end

  test "email should be unique and case-insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be lowercase before committing to database" do
    mixed_email = "maiL@EXAMple.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "password should be at least 5 characters long" do
    @chef.password = @chef.password_confirmation = "a" * 4
    assert_not @chef.valid?
  end

  test "associated recipes should be destroyed" do
    @chef.save
    @chef.chef_recipes.create!(name: "test destroy", description: "test description")
    assert_difference 'ChefRecipe.count', -1 do
      @chef.destroy
    end
  end
end
