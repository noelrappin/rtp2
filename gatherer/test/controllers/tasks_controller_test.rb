require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  setup do
    ActionMailer::Base.deliveries.clear # <label id="code.clear_mailers" />
  end

  test "on update with no completion, no email is sent" do
    task = Task.create!(title: "Write section on testing mailers", size: 2)
    patch :update, id: task.id, task: {size: 3}
    assert_equal 0, ActionMailer::Base.deliveries.size # <label id="code.no_emails" />
  end

  ##START:with_email
  test "on update with completion, send an email" do
    task = Task.create!(title: "Write section on testing mailers", size: 2)
    patch :update, id: task.id, task: {size: 3, completed: true}
    task.reload
    refute_nil task.completed_at
    assert_equal 1, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.first
    assert_equal "A task has been completed", email.subject
    assert_equal ["monitor@tasks.com"], email.to
    assert_match /Write section on testing mailers/, email.body.to_s
  end
  ##END:with_email

end
