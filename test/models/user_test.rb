require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "normalizes email and authenticates with secure password" do
    user = User.new(email: "  NEW.AFU@Example.COM  ", password: "password123", password_confirmation: "password123")

    assert user.valid?
    assert_equal "new.afu@example.com", user.email
    assert user.authenticate("password123")
    assert_not user.authenticate("wrong-password")
  end

  test "requires a unique email address" do
    duplicate = User.new(email: users(:afu).email, password: "password123", password_confirmation: "password123")

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end
end
