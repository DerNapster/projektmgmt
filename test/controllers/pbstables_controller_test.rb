require 'test_helper'

class PbstablesControllerTest < ActionController::TestCase
  setup do
    @pbstable = pbstables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pbstables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pbstable" do
    assert_difference('Pbstable.count') do
      post :create, pbstable: { name: @pbstable.name }
    end

    assert_redirected_to pbstable_path(assigns(:pbstable))
  end

  test "should show pbstable" do
    get :show, id: @pbstable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pbstable
    assert_response :success
  end

  test "should update pbstable" do
    patch :update, id: @pbstable, pbstable: { name: @pbstable.name }
    assert_redirected_to pbstable_path(assigns(:pbstable))
  end

  test "should destroy pbstable" do
    assert_difference('Pbstable.count', -1) do
      delete :destroy, id: @pbstable
    end

    assert_redirected_to pbstables_path
  end
end
