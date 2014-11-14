require 'rails_helper' # <label id="code.require_rails" />

RSpec.describe Project do # <label id="code.describe" />
  it "considers a project with no tasks to be done" do # <label id="code.id" />
    project = Project.new
    expect(project.done?).to be_truthy # <label id="code.expect" />
  end

##START:second_spec
  it "knows that a project with an incomplete task is not done" do
    project = Project.new
    task = Task.new
    project.tasks << task
    expect(project.done?).to be_falsy
  end
end
##END:second_spec
