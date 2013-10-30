require 'test_helper'

class ProjectWithDataTest < ActiveSupport::TestCase

  setup :create_project_with_data

  def create_project_with_data
    @project = Project.new
    done = Task.new(size: 2, completed: true)
    small_not_done = Task.new(size: 1)
    large_not_done = Task.new(size: 4)
    @project.tasks = [done, small_not_done, large_not_done]
  end

  test "a project can tell its total size" do
    assert_equal(7, @project.total_size)
  end

  test "a project can tell how much is left" do
    assert_equal(5, @project.remaining_size)
  end

end
