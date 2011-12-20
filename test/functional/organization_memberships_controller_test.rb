require File.dirname(__FILE__) + '/../test_helper'

class OrganizationMembershipsControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = 1
  end
  
  test "should create organization membership" do
    assert_difference 'Organization.find(1).projects.count', 1 do
      post :create, :membership => {:organization_id => 1, :project_id => 3, :role_ids => ['1', '2']}
    end
  end
  
  test "should update organization membership" do
    put :update, :id => 1, :membership => { :role_ids => ['1', '3']}
    assert_equal [1,3], OrganizationMembership.find(1).role_ids.sort
  end
  
  test "should destroy membership" do
    assert_difference 'Organization.find(1).projects.count', -1 do
      delete :destroy, :id => 3
    end
  end

  test "should destroy membership inside a project" do
    assert_difference 'Organization.find(1).projects.count', -1 do
      delete :destroy_in_project, :id => 3
    end
    assert_redirected_to '/projects/onlinestore/settings/members'
  end
end
