require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  test "the project method creates a project" do
    post :create, project: {name: "Runway", tasks: "start something:2"} # <label id="call_post" />
    assert_redirected_to projects_path # <label id="assert_redirect" />
    assert_equal "Runway", assigns(:action).project.name # <label id="assert_assigns" />
  end

end
