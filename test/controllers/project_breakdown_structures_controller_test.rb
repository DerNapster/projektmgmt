require 'test_helper'

class ProjectBreakdownStructuresControllerTest < ActionController::TestCase
  setup do
    @project_breakdown_structure = project_breakdown_structures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_breakdown_structures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_breakdown_structure" do
    assert_difference('ProjectBreakdownStructure.count') do
      post :create, project_breakdown_structure: { title: @project_breakdown_structure.title }
    end

    assert_redirected_to project_breakdown_structure_path(assigns(:project_breakdown_structure))
  end

  test "should show project_breakdown_structure" do
    get :show, id: @project_breakdown_structure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_breakdown_structure
    assert_response :success
  end

  test "should update project_breakdown_structure" do
    patch :update, id: @project_breakdown_structure, project_breakdown_structure: { title: @project_breakdown_structure.title }
    assert_redirected_to project_breakdown_structure_path(assigns(:project_breakdown_structure))
  end

  test "should destroy project_breakdown_structure" do
    assert_difference('ProjectBreakdownStructure.count', -1) do
      delete :destroy, id: @project_breakdown_structure
    end

    assert_redirected_to project_breakdown_structures_path
  end
end
