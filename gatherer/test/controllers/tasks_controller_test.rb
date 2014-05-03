require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  setup do
    ActionMailer::Base.deliveries.clear # <label id="code.clear_mailers" />
  end

  test "on update with no completion, no email is sent" do
    task = Task.create!(title: "Write section on testing mailers",
        size: 2)
    patch :update, id: task.id, task: {size: 3}
    assert_equal 0, ActionMailer::Base.deliveries.size # <label id="code.no_emails" />
  end

end
