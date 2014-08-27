require 'test_helper'

class InstagrampostersControllerTest < ActionController::TestCase
  setup do
    @instagramposter = instagramposters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instagramposters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instagramposter" do
    assert_difference('Instagramposter.count') do
      post :create, instagramposter: { ig_id: @instagramposter.ig_id, poster_id: @instagramposter.poster_id, screen_name: @instagramposter.screen_name }
    end

    assert_redirected_to instagramposter_path(assigns(:instagramposter))
  end

  test "should show instagramposter" do
    get :show, id: @instagramposter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @instagramposter
    assert_response :success
  end

  test "should update instagramposter" do
    patch :update, id: @instagramposter, instagramposter: { ig_id: @instagramposter.ig_id, poster_id: @instagramposter.poster_id, screen_name: @instagramposter.screen_name }
    assert_redirected_to instagramposter_path(assigns(:instagramposter))
  end

  test "should destroy instagramposter" do
    assert_difference('Instagramposter.count', -1) do
      delete :destroy, id: @instagramposter
    end

    assert_redirected_to instagramposters_path
  end
end
