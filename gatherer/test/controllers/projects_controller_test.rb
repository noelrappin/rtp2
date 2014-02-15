require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  test "the project method creates a project" do
    post :create, project: {name: "Runway", tasks: "start something:2"}
    assert_redirected_to projects_path
    assert_equal "Runway", assigns[:action].project.name
  end

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
      Project.any_instance.stubs(:save).returns(false) # <label id="create_any_instance" />
      post :create, :project => {:name => 'Project Runway'} # <label id="create_controller" />
      assert_template('new') # <label id="create_template" />
    end
  end

  test "fail update gracefully" do
    sample = Project.create!(name: "Test Project")
    Project.any_instance.stubs(:update_attributes).returns(false) # <label id="update_any_instance" />
    patch :update, id: projects(:one), project: {name: "Fred"} # <label id="update_controller" />
    assert_template('edit') # <label id="update_template" />
    actual = Project.find(sample.id)
    assert_not_equal("Fred", actual.name) # <label id="update_find" />
  end
##END:  mock_failure
end
