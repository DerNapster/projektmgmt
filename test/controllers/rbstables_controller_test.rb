require 'test_helper'

class RbstablesControllerTest < ActionController::TestCase
  setup do
    @rbstable = rbstables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rbstables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rbstable" do
    assert_difference('Rbstable.count') do
      post :create, rbstable: { name: @rbstable.name }
    end

    assert_redirected_to rbstable_path(assigns(:rbstable))
  end

  test "should show rbstable" do
    get :show, id: @rbstable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rbstable
    assert_response :success
  end

  test "should update rbstable" do
    patch :update, id: @rbstable, rbstable: { name: @rbstable.name }
    assert_redirected_to rbstable_path(assigns(:rbstable))
  end

  test "should destroy rbstable" do
    assert_difference('Rbstable.count', -1) do
      delete :destroy, id: @rbstable
    end

    assert_redirected_to rbstables_path
  end
end
