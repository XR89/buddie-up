require "test_helper"

class FavouriteGamesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favourite_games_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favourite_games_destroy_url
    assert_response :success
  end
end
