require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "can not view a project it is not a part of" do
    user = User.new
    project = Project.new
    refute user.can_view?(project)
  end

  test "can view a project it is a part of" do
    user = User.create!(email: "user@example.com", password: "password")
    project = Project.create!(name: "Project Gutenberg")
    user.roles.create(project: project)
    assert user.can_view?(project)
  end

end
