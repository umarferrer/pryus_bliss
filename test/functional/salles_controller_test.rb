require 'test_helper'

class SallesControllerTest < ActionController::TestCase
  setup do
    @salle = salles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:salles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create salle" do
    assert_difference('Salle.count') do
      post :create, salle: @salle.attributes
    end

    assert_redirected_to salle_path(assigns(:salle))
  end

  test "should show salle" do
    get :show, id: @salle.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @salle.to_param
    assert_response :success
  end

  test "should update salle" do
    put :update, id: @salle.to_param, salle: @salle.attributes
    assert_redirected_to salle_path(assigns(:salle))
  end

  test "should destroy salle" do
    assert_difference('Salle.count', -1) do
      delete :destroy, id: @salle.to_param
    end

    assert_redirected_to salles_path
  end
end
