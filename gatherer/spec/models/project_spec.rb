require 'rails_helper' # <label id="code.require_rails" />

RSpec.describe Project do # <label id="code.describe" />
  it "considers a project with no tasks to be done" do # <label id="code.id" />
    project = Project.new
    expect(project.done?).to be_truthy # <label id="code.expect" />
  end
end
