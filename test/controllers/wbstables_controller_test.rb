require 'test_helper'

class WbstablesControllerTest < ActionController::TestCase
  setup do
    @wbstable = wbstables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wbstables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wbstable" do
    assert_difference('Wbstable.count') do
      post :create, wbstable: { name: @wbstable.name, project_id: @wbstable.project_id }
    end

    assert_redirected_to wbstable_path(assigns(:wbstable))
  end

  test "should show wbstable" do
    get :show, id: @wbstable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wbstable
    assert_response :success
  end

  test "should update wbstable" do
    patch :update, id: @wbstable, wbstable: { name: @wbstable.name, project_id: @wbstable.project_id }
    assert_redirected_to wbstable_path(assigns(:wbstable))
  end

  test "should destroy wbstable" do
    assert_difference('Wbstable.count', -1) do
      delete :destroy, id: @wbstable
    end

    assert_redirected_to wbstables_path
  end
end
