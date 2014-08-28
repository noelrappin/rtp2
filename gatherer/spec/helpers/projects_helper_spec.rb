require 'rails_helper'

RSpec.describe ProjectsHelper, :type => :helper do
  let(:project) { Project.new(name: "Project Runway") }  # <label id="code.create" />

  it "augments with status info" do
    allow(project).to receive(:on_schedule?).and_return(true) # <label id="code.mock_project" />
    actual = helper.name_with_status(project) # <label id="code.actual" />
    expect(actual).to have_selector("span.on_schedule", text: "Project Runway")
  end

  ##START:second_test
  it "augments project name with status info when behind schedule" do
    allow(project).to receive(:on_schedule?).and_return(false)
    actual = helper.name_with_status(project)
    expect(actual).to have_selector("span.behind_schedule", text: "Project Runway")
  end
  ##END:second_test

end
