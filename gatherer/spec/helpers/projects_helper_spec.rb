require 'rails_helper'

RSpec.describe ProjectsHelper, :type => :helper do
  let(:project) { Project.new(name: "Project Runway") }  # <label id="code.create" />

  it "augments with status info" do
    allow(project).to receive(:on_schedule?).and_return(true) # <label id="code.mock_project" />
    actual = helper.name_with_status(project) # <label id="code.actual" />
    expected = "<span class='on_schedule'>Project Runway</span>" # <label id="code.expected" />
    expect(actual).to have_selector("span.on_schedule", text: "Project Runway")
  end

end
