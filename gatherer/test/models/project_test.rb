##START: test_one
require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "a project with no tasks is done" do
    project = Project.new
    assert(project.done?)
  end

  ##START: test_two
  test "a project with an incomplete task is not done" do
    project = Project.new
    task = Task.new
    project.tasks << task
    refute(project.done?)
  end
  ##END:  test_two

  ##START: test_three
  test "a project is only done if all its tests are done" do
    project = Project.new
    task = Task.new
    project.tasks << task
    refute(project.done?)
    task.mark_completed
    assert(project.done?)
  end
  ##END:  test_three

end
##END: test_one
