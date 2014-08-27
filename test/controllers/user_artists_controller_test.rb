require 'test_helper'

class UserArtistsControllerTest < ActionController::TestCase
  setup do
    @user_artist = user_artists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_artists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_artist" do
    assert_difference('UserArtist.count') do
      post :create, user_artist: { artist_id: @user_artist.artist_id, user_id: @user_artist.user_id }
    end

    assert_redirected_to user_artist_path(assigns(:user_artist))
  end

  test "should show user_artist" do
    get :show, id: @user_artist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_artist
    assert_response :success
  end

  test "should update user_artist" do
    patch :update, id: @user_artist, user_artist: { artist_id: @user_artist.artist_id, user_id: @user_artist.user_id }
    assert_redirected_to user_artist_path(assigns(:user_artist))
  end

  test "should destroy user_artist" do
    assert_difference('UserArtist.count', -1) do
      delete :destroy, id: @user_artist
    end

    assert_redirected_to user_artists_path
  end
end
