require "test_helper"

class WongshareControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get wongshare_new_url
    assert_response :success
  end
end
