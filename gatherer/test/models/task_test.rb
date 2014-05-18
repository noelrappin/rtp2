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
    task.mark_completed(6.months.ago) # <label id="code.old_complete" />
    refute(task.counts_toward_velocity?)
    assert_equal(0, task.points_toward_velocity)
  end

  test "a task completed recently counts toward velocity" do
    task = Task.new(size: 3)
    task.mark_completed(1.day.ago) # <label id="code.new_complete" />
    assert(task.counts_toward_velocity?)
    assert_equal(3, task.points_toward_velocity)
  end
  ##END:vel_test

  test "it finds completed tasks" do
    Task.delete_all
    complete = Task.create(completed_at: 1.day.ago, title: "Completed")
    incomplete = Task.create(completed_at: nil, title: "Not Completed")
    assert_equal([complete], Task.complete.to_a)
  end

  ##START:first_or_last
  test "it finds that a test is first or last" do
    project = Project.create!(name: "Project")
    first = project.tasks.create!(project_order: 1)
    second = project.tasks.create!(project_order: 2)
    third = project.tasks.create!(project_order: 3)
    assert first.first_in_project?
    refute first.last_in_project?
    refute second.first_in_project?
    refute second.last_in_project?
    refute third.first_in_project?
    assert third.last_in_project?
  end
  ##END:first_or_last

end
