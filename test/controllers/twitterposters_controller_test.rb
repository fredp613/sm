require 'test_helper'

class TwitterpostersControllerTest < ActionController::TestCase
  setup do
    @twitterposter = twitterposters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitterposters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitterposter" do
    assert_difference('Twitterposter.count') do
      post :create, twitterposter: { poster_id: @twitterposter.poster_id, screen_name: @twitterposter.screen_name, twitter_id: @twitterposter.twitter_id }
    end

    assert_redirected_to twitterposter_path(assigns(:twitterposter))
  end

  test "should show twitterposter" do
    get :show, id: @twitterposter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twitterposter
    assert_response :success
  end

  test "should update twitterposter" do
    patch :update, id: @twitterposter, twitterposter: { poster_id: @twitterposter.poster_id, screen_name: @twitterposter.screen_name, twitter_id: @twitterposter.twitter_id }
    assert_redirected_to twitterposter_path(assigns(:twitterposter))
  end

  test "should destroy twitterposter" do
    assert_difference('Twitterposter.count', -1) do
      delete :destroy, id: @twitterposter
    end

    assert_redirected_to twitterposters_path
  end
end
