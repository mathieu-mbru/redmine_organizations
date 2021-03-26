require "spec_helper"

describe ProjectsController, :type => :controller do

  render_views

  fixtures :projects, :users, :members, :member_roles, :functions

  it "Should show the description of the functional role when the cursor is placed on the name of the role" do
    @request.session[:user_id] = 1
    Function.find(1).update_attribute :description , 'desforfunction1'
    Function.find(2).update_attribute :description , 'desforfunction2'

    fun_mem = MemberFunction.new
    fun_mem.member = Project.find(1).members.first
    fun_mem.function = Project.find(1).functions.first
    fun_mem.save

    fun_mem = MemberFunction.new
    fun_mem.member = Project.find(1).members.first
    fun_mem.function = Project.find(1).functions.second
    fun_mem.save

    get :settings, :params => {
        :id => 1,
        :tab => "functional_roles",
        :nav => "members",
      }
     
    assert_select 'label[title=?][style=?]', 'desforfunction1', "cursor: pointer"
    assert_select 'label[title=?][style=?]', 'desforfunction2', "cursor: pointer"
  end
 
end
