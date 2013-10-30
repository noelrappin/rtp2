require 'test_helper'

class ProjectWithDataTest < ActiveSupport::TestCase

  test "a project can tell how much is left" do
    project = Project.new
    done = Task.new(size: 2)
    small_not_done = Task.new(size: 1)
    large_not_done = Task.new(size: 4)
    assert_equal(6, project.total_size)
    assert_equal(5, project.remaining_size)
  end

end
