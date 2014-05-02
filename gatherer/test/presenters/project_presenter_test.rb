require 'test_helper'

class ProjectPresenterTest < ActiveSupport::TestCase

  setup do
    @project = Project.new(name: "Project Runway")
    @presenter = ProjectPresenter.new(@project)
  end

  test "project name with status info" do
    @project.stubs(:on_schedule?).returns(true)
    expected = "<span class='on_schedule'>Project Runway</span>"
    assert_equal(expected, @presenter.name_with_status)
  end

  test "project name with status info behind sechdule" do
    @project.stubs(:on_schedule?).returns(false)
    expected = "<span class='behind_schedule'>Project Runway</span>"
    assert_equal(expected, @presenter.name_with_status)
  end
end
