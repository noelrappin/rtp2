require "test_helper"

class AddTaskTest < Capybara::Rails::TestCase

  include Warden::Test::Helpers

  setup do
    login_as users(:user)
  end

  test "i can add and reorder a task" do
    visit project_path(projects(:bluebook))
    fill_in "Task", with: "Find UFOs"
    select "2", from: "Size"
    click_on "Add Task"
    assert_equal project_path(projects(:bluebook)), current_path
    within("#task_3") do
      assert_selector(".name", text: "Find UFOs")
      assert_selector(".size", text: "2")
      refute_selector("a", text: "Down")
      click_on("Up")
    end
    assert_equal project_path(projects(:bluebook)), current_path
    within("#task_2") do
      assert_selector(".name", text: "Find UFOs")
    end
  end
end
