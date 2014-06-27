require 'rails_helper'

include Warden::Test::Helpers

describe "adding a new task" do

  fixtures :all

  before(:each) do
    users(:user).update_attributes(email: "noelrappin@gmail.com")
    tasks(:one).update_attributes(user_id: users(:user).id)
    login_as users(:user)
  end

  it "shows a gravatar", :vcr do
    visit project_path(projects(:bluebook))
    url = "http://www.gravatar.com/avatar/6b767d8a4c9910e007c122d81eb4de73"
    within("#task_1") do
      expect(page).to have_selector(".completed_by", text: users(:user).email)
      expect(page).to have_selector("img[src='#{url}']")
    end
  end

end
