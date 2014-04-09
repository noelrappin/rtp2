require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "a completed task is complete" do
    task = Task.new
    refute(task.complete?)
    task.mark_completed
    assert(task.complete?)
  end

  ##START:vel_test
  test "an uncompleted task does not count toward velocity" do
    task = Task.new(size: 3)
    refute(task.counts_toward_velocity?)
    assert_equal(0, task.points_toward_velocity)
  end

  test "a task completed long ago does not count toward velocity" do
    task = Task.new(size: 3)
    task.complete!(6.months.ago) # <label id="code.old_complete" />
    refute(task.counts_toward_velocity?)
    assert_equal(0, task.points_toward_velocity)
  end

  test "a task completed recently counts toward velocity" do
    task = Task.new(size: 3)
    task.complete!(1.day.ago) # <label id="code.new_complete" />
    assert(task.counts_toward_velocity?)
    assert_equal(3, task.points_toward_velocity)
  end
  ##END:vel_test

end
