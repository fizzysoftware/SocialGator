require 'test_helper'

class ScheduledPostsControllerTest < ActionController::TestCase
  setup do
    @scheduled_post = scheduled_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scheduled_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheduled_post" do
    assert_difference('ScheduledPost.count') do
      post :create, scheduled_post: @scheduled_post.attributes
    end

    assert_redirected_to scheduled_post_path(assigns(:scheduled_post))
  end

  test "should show scheduled_post" do
    get :show, id: @scheduled_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheduled_post
    assert_response :success
  end

  test "should update scheduled_post" do
    put :update, id: @scheduled_post, scheduled_post: @scheduled_post.attributes
    assert_redirected_to scheduled_post_path(assigns(:scheduled_post))
  end

  test "should destroy scheduled_post" do
    assert_difference('ScheduledPost.count', -1) do
      delete :destroy, id: @scheduled_post
    end

    assert_redirected_to scheduled_posts_path
  end
end
