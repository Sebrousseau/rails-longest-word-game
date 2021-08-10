require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home:get" do
    get pages_home:get_url
    assert_response :success
  end

  test "should get about:post" do
    get pages_about:post_url
    assert_response :success
  end
end
