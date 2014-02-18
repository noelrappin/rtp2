require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  ##START:state_test
  test "the project method creates a project" do
    post :create, project: {name: "Runway", tasks: "start something:2"}
    assert_redirected_to projects_path
    assert_equal "Runway", assigns[:action].project.name
  end
  ##END:state_test

  ##START:mock_test
  test "the project method creates a project (mock version)" do
    fake_project = mock(create: true) # <label id="mock_project" />
    CreatesProject.expects(:new)  # <label id="mock_action" />
        .with(name: "Runway", task_string: "start something:2")
        .returns(fake_project)
    post :create, project: {name: "Runway", tasks: "start something:2"}
    assert_redirected_to projects_path
    refute_nil assigns[:action] # <label id="mock_refute_nil" />
  end
  ##END:mock_test

  ##START: failure
  test "on failure we go back to the form" do
    post :create, project: {name: "", tasks: ""} # <label id="blank_form" />
    assert_template :new # <label id="assert_template" />
    refute_nil assigns(:project) # <label id="refute_nil" />
  end
  ##END: failure

##START: mock_failure
  test "fail create gracefully" do
    assert_no_difference('Project.count') do
      Project.any_instance.expects(:save).returns(false) # <label id="create_any_instance" />
      post :create, :project => {:name => 'Project Runway'} # <label id="create_controller" />
      assert_template('new') # <label id="create_template" />
    end
  end

  test "fail update gracefully" do
    sample = Project.create!(name: "Test Project")
    Project.any_instance.expects(:update_attributes).returns(false) # <label id="update_any_instance" />
    patch :update, id: projects(:one), project: {name: "Fred"} # <label id="update_controller" />
    assert_template('edit') # <label id="update_template" />
    actual = Project.find(sample.id)
    assert_not_equal("Fred", actual.name) # <label id="update_find" />
  end
##END:  mock_failure

##START: stub_with
  test "let's stub a class again" do
    Project.stubs(:find).with(1).returns(
        Project.new(:name => "Project Greenlight"))
    Project.stubs(:find).with(2).returns(
        Project.new(:name => "Project Blue Book"))
    assert_equal("Project Greenlight", Project.find(1).name)
    assert_equal("Project Blue Book", Project.find(2).name)
  end
##END:  stub_with
end
