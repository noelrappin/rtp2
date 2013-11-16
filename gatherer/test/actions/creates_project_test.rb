require 'test_helper'

class CreatesProjectTest < ActiveSupport::TestCase

  test "creates a project given a name" do
    creator = CreatesProject.new(name: "Project Runway")
    creator.build
    assert_equal "Project Runway", creator.project.name
  end

end
