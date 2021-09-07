require "test_helper"

class AvoidUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get avoid_users_create_url
    assert_response :success
  end
end
