##START: test_one
require 'test_helper' # <label id="test_require_01" />

class ProjectTest < ActiveSupport::TestCase # <label id="test_superclass" />

  test "a project with no tasks is done" do # <label id="test_test" />
    project = Project.new
    assert(project.done?) # <label id="test_assert" />
  end

end
##END: test_one
