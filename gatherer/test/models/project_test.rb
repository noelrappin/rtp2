##START: test_one
require 'test_helper' # <label id="code.test_require" />

class ProjectTest < ActiveSupport::TestCase # <label id="code.test_superclass" />

  test "a project with no tasks is done" do # <label id="code.test_test" />
    project = Project.new
    assert(project.done?) # <label id="code.test_assert" />
  end

end
##END: test_one
