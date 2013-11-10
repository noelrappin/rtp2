require "test_helper"

class AddTaskTest < Capybara::Rails::TestCase
  test "a user can add a task to a project" do
    visit new_task_path                              # <label id="when_start" />
    fill_in "Title", with: "Something to do"
    fill_in project_name, with: "Project Runway"
    select "3", from: "Size"
    click_on("Submit")                              # <label id="when_end" />
    visit projects_path
    click_on("Project Runway")                      # <label id="then_start" />
    assert_content("Something to do")
  end

end

