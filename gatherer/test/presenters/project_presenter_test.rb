#require 'test_helper'

class ProjectPresenterTest < Minitest::Test

  def setup
    @project = Project.new(name: "Project Runway")
    @presenter = ProjectPresenter.new(@project)
  end

  def test_project_name_with_status_info
    @project.stubs(:on_schedule?).returns(true)
    expected = "<span class='on_schedule'>Project Runway</span>"
    assert_equal(expected, @presenter.name_with_status)
  end

  def test_project_name_with_status_info_behind_sechdule
    @project.stubs(:on_schedule?).returns(false)
    expected = "<span class='behind_schedule'>Project Runway</span>"
    assert_equal(expected, @presenter.name_with_status)
  end
end
