require 'test_helper'

class ProjectWithDataTest < ActiveSupport::TestCase

  test "a project can tell how much is left" do
    project = Project.new
    done = Task.new(size: 2, completed: true)
    small_not_done = Task.new(size: 1)
    large_not_done = Task.new(size: 4)
    project.tasks = [done, small_not_done, large_not_done]
    assert_equal(7, project.total_size)
    assert_equal(5, project.remaining_size)
  end

end
