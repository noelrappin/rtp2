require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  setup do
    ActionMailer::Base.deliveries.clear
    sign_in users(:user)
  end

  test "on update with no completion, no email is sent" do
    task = Task.create!(title: "Write section on testing mailers", size: 2)
    patch :update, id: task.id, task: {size: 3}
    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  test "on update with completion, send an email" do
    task = Task.create!(title: "Write section on testing mailers", size: 2)
    patch :update, id: task.id, task: {size: 3, completed: true}
    task.reload  # <label id="code.reload" />
    refute_nil task.completed_at
    assert_equal 1, ActionMailer::Base.deliveries.size
    email = ActionMailer::Base.deliveries.first # <label id="code.check_email_start" />
    assert_equal "A task has been completed", email.subject
    assert_equal ["monitor@tasks.com"], email.to
    assert_match /Write section on testing mailers/, email.body.to_s # <label id="code.check_email_end" />
  end

  ##START:create
  test "a user can create a task for a project they belong to" do
    project = Project.create!(name: "Project Runway")
    users(:user).projects << project
    users(:user).save!
    post :create, task: {
        project_id: project.id, title: "just do it", size: "1" }
    assert_equal project.reload.tasks.first.title, "just do it"
  end

  test "a user can not create a task for a project they do not belong to" do
    project = Project.create!(name: "Project Runway")
    post :create, task: {
        project_id: project.id, title: "just do it", size: "1" }
    assert_equal project.reload.tasks.size, 0
  end
  ##END:create

end
