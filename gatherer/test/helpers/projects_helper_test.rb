require 'test_helper'

class ProjectsHelperTest < ActionView::TestCase

  test "project name with status info" do
    project = Project.new(name: "Project Runway") # <label id="code.create" />
    project.stubs(:on_schedule?).returns(true) # <label id="code.mock_project" />
    actual = name_with_status(project) # <label id="code.actual" />
    expected = "<span class='on_schedule'>Project Runway</span>" # <label id="code.expected" />
    assert_dom_equal expected, actual # <label id="code.comparison" />
  end
end
