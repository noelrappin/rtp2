require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "a project with no tasks is done" do
    project = Project.new
    assert(project.done?)
  end

  test "a project with an incomplete task is not done" do
    project = Project.new
    task = Task.new
    project.tasks << task
    refute(project.done?)
  end

  ##START: test_three
  test "a project is only done if all its tasks are done" do
    project = Project.new
    task = Task.new
    project.tasks << task
    refute(project.done?)
    task.mark_completed
    assert(project.done?)
  end

  test "a project with no completed tasks projects correctly" do
    project = Project.new
    assert_equal(0, project.completed_velocity)
    assert_equal(0, project.current_rate)
    assert(project.projected_days_remaining.nan?)
    refute(project.on_schedule?)
  end

  ##START:stub_one
  test "let's stub an object" do
    project = Project.new(name: "Project Greenlight")
    project.stubs(:name)
    assert_nil(project.name)
  end
  ##END:stub_one

  ##START:stub_two
  test "let's stub an object again" do
    project = Project.new(name: "Project Greenlight")
    project.stubs(:name).returns("Fred")
    assert_equal("Fred", project.name)
  end
  ##END:stub_two

##START: stub_class
  test "let's stub a class" do
    Project.stubs(:find).returns(Project.new(:name => "Project Greenlight"))
    project = Project.find(1)
    assert_equal("Project Greenlight", project.name)
  end
##END:  stub_class

##START: multi_return
  test "stub with multiple returns" do
    stubby = Project.new
    stubby.stubs(:user_count).returns(1, 2)
    assert_equal(1, stubby.user_count)
    assert_equal(2, stubby.user_count)
    assert_equal(2, stubby.user_count)
  end
##END:  multi_return

##START: mock_one
  test "let's mock an object" do
    mock_project = Project.new(:name => "Project Greenlight")
    mock_project.expects(:name).returns("Fred")
    assert_equal("Fred", mock_project.name)
  end
##END:  mock_one


end
