require 'test_helper'

class ProjectsHelperTest < ActionView::TestCase

  test "project name with status info" do
    project = Project.new(name: "Project Runway")
    project.stubs(:on_schedule?).returns(true)
    actual = name_with_status(project)
    expected = "<span class='on_schedule'>Project Runway</span>"
    assert_dom_equal expected, actual
  end

  ##START:second_test
  test "project name with status info behind sechdule" do
    project = Project.new(name: "Project Runway")
    project.stubs(:on_schedule?).returns(false)
    actual = name_with_status(project)
    expected = "<span class='behind_schedule'>Project Runway</span>"
    assert_dom_equal expected, actual
  end
  ##END:second_test
end
