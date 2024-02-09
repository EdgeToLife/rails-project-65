require "test_helper"

class Web::UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "Should get index" do
    sign_in @user
    get user_profile_url
    assert_response :success
  end

  test "Should not get index" do
    get user_profile_url
    assert_redirected_to root_path
  end
end
