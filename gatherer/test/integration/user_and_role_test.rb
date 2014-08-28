require "test_helper"

class UserAndRoleTest < Capybara::Rails::TestCase

  def log_in_as(user) # <label id="code.security_log_in" />
    visit new_user_session_path
    fill_in("user_email", :with => user.email)
    fill_in("user_password", :with => user.password)
    click_button("Log in")
  end

  setup do
    @user = User.create(email: "test2@example.com", password: "password")
  end

  test "a logged in user can view the project index page" do
    log_in_as(@user)
    visit(projects_path)
    assert_equal projects_path, current_path
  end

  ##START:no_login
  test "without a login, the user can't see the project page" do
    visit(projects_path)
    assert_equal new_user_session_path, current_path
  end
  ##END:no_login

  ##START:basic_role
  test "a user who is part of a project can see that project" do
    project = Project.create(name: "Project Gutenberg")
    project.roles.create(user: @user)
    log_in_as(@user)
    visit(project_path(project))
    assert_equal project_path(project), current_path
  end

  test "a user who is not part of a project can not see that project" do
    project = Project.create(name: "Project Gutenberg")
    log_in_as(@user)
    visit(project_path(project))
    refute_equal project_path(project), current_path
  end
  ##END:basic_role

end
