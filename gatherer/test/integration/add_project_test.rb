require "test_helper"

class AddProjectTest < Capybara::Rails::TestCase
  test "a user can add a a project and give it tasks" do
    visit new_project_path
    fill_in "Title", with: "Project Runway"         # <label id="when_start" />
    fill_in "Tasks", with: "Task 1:3\nTask2:5"
    click_on("Submit")
    visit projects_path                             # <label id="when_end" />
    assert_content("Project Runway")                # <label id="then_start" />
    assert_content("8")
  end

end



