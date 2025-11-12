require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)  # Use fixture instead of creating
    sign_in @user
  end

  test "should get index" do
    get dashboard_url
    assert_response :success
  end

  test "should require authentication" do
    sign_out @user
    get dashboard_url
    assert_redirected_to new_user_session_url
  end
end