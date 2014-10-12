require 'spec_helper'

describe User do

  it "cannot view a project it is not a part of" do
    user = User.new
    project = Project.new
    expect(user.can_view?(project)).to be_falsy
  end

  it "can view a project it is a part of" do
    user = User.create!(email: "user@example.com", password: "password")
    project = Project.create!(name: "Project Gutenberg")
    user.roles.create(project: project)
    expect(user.can_view?(project)).to be_truthy
  end
end
