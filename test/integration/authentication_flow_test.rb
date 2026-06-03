require "test_helper"

class AuthenticationFlowTest < ActionDispatch::IntegrationTest
  test "user can register, log out, and log back in" do
    get sign_up_path
    assert_response :success

    assert_difference "User.count", 1 do
      post sign_up_path, params: {
        user: {
          email: "new.user@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
    assert_redirected_to tasks_path
    follow_redirect!
    assert_select "body", /Welcome/

    delete logout_path
    assert_redirected_to login_path

    post login_path, params: { email: "new.user@example.com", password: "password123" }
    assert_redirected_to tasks_path
  end

  test "rejects invalid login" do
    post login_path, params: { email: users(:afu).email, password: "bad" }

    assert_response :unprocessable_entity
    assert_select "body", /Invalid email or password/
  end
end
