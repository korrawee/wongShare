require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new.html.erb" do
    get sessions_new.html.erb_url
    assert_response :success
  end
end
