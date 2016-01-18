require 'test_helper'

class DelphisControllerTest < ActionController::TestCase
  setup do
    @delphi = delphis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delphis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delphi" do
    assert_difference('Delphi.count') do
      post :create, delphi: { name: @delphi.name, optimistic: @delphi.optimistic, pessimistic: @delphi.pessimistic, realistic: @delphi.realistic, round: @delphi.round, workpackage_id: @delphi.workpackage_id }
    end

    assert_redirected_to delphi_path(assigns(:delphi))
  end

  test "should show delphi" do
    get :show, id: @delphi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delphi
    assert_response :success
  end

  test "should update delphi" do
    patch :update, id: @delphi, delphi: { name: @delphi.name, optimistic: @delphi.optimistic, pessimistic: @delphi.pessimistic, realistic: @delphi.realistic, round: @delphi.round, workpackage_id: @delphi.workpackage_id }
    assert_redirected_to delphi_path(assigns(:delphi))
  end

  test "should destroy delphi" do
    assert_difference('Delphi.count', -1) do
      delete :destroy, id: @delphi
    end

    assert_redirected_to delphis_path
  end
end
