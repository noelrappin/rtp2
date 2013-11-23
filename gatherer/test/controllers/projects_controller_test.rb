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
end
