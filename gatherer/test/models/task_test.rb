require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "a completed task is complete" do
    task = Task.new
    refute(task.complete?)
    task.complete!
    assert(task.complete?)
  end

end
