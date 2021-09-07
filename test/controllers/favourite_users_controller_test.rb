require "test_helper"

class FavouriteUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favourite_users_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favourite_users_destroy_url
    assert_response :success
  end
end
