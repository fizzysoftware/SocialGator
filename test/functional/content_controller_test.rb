require 'test_helper'

class ContentControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get custom" do
    get :custom
    assert_response :success
  end

  test "should get textual" do
    get :textual
    assert_response :success
  end

  test "should get images" do
    get :images
    assert_response :success
  end

  test "should get videos" do
    get :videos
    assert_response :success
  end

end
