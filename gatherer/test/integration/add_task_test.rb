require "test_helper"

class AddTaskTest < Capybara::Rails::TestCase

  include Warden::Test::Helpers

  setup do
    Capybara.current_driver = Capybara.javascript_driver
    projects(:bluebook).roles.create(user: users(:user))
    login_as users(:user)

  end

  teardown do
    Capybara.current_driver = Capybara.default_driver
  end

  test "i can add and reorder a task" do
    visit project_path(projects(:bluebook))
    fill_in "Task", with: "Find UFOs"
    select "2", from: "Size"
    click_on "Add Task"
    assert_equal project_path(projects(:bluebook)), current_path
    added_task = Task.last
    within("#task_#{added_task.id}") do
      assert_selector(".name", text: "Find UFOs")
      assert_selector(".size", text: "2")
      refute_selector("a", text: "Down")
      click_on("Up")
    end
    assert_equal project_path(projects(:bluebook)), current_path
    assert_selector("tbody:nth-child(2) .name", text: "Find UFOs")
  end
end
