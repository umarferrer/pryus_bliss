require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get machine_historique" do
    get :machine_historique
    assert_response :success
  end

end
