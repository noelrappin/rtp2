require "test_helper"

class AddProjectTest < Capybara::Rails::TestCase
  test "a user can add a a project and give it tasks" do
    visit new_project_path                          # <label id="when_start" />
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Task 1:3\nTask2:5"
    click_on("Create Project")
    visit projects_path                             # <label id="when_end" />
    assert_content("Project Runway")                # <label id="then_start" />
    assert_content("8")
  end

end




