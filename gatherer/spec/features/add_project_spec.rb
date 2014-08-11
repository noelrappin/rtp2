require "rails_helper"

describe "adding projects" do

  it "allows a user to create a project with tasks", :pending do
    visit new_project_path # <label id="code.when_start" />
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Task 1:3\nTask 2:5"
    click_on("Create Project") # <label id="code.when_end" />
    visit projects_path # <label id="code.then_start" />
    expect(page).to have_content("Project Runway")
    expect(page).to have_content("8")
  end

end
