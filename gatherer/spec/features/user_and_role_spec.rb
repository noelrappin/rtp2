require "rails_helper"

describe "with users and roles" do

  def log_in_as(user) # <label id="code.security_log_in" />
    visit new_user_session_path
    fill_in("user_email", :with => user.email)
    fill_in("user_password", :with => user.password)
    click_button("Log in")
  end

  let(:user) { User.create(email: "test@example.com", password: "password") }

  it "allows a logged-in user to view the project index page" do
    log_in_as(user)
    visit(projects_path)
    expect(current_path).to eq(projects_path)
  end

end
