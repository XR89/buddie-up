require "test_helper"

class GameSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get game_search_index_url
    assert_response :success
  end
end
