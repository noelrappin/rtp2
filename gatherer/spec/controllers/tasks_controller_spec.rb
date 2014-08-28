require 'rails_helper'

RSpec.describe TasksController, :type => :controller do

  before(:example) do
    sign_in User.create!(email: "rspec@example.com", password: "password")
    ActionMailer::Base.deliveries.clear # <label id="code.clear_mailers" />
  end

  describe "PATCH update" do
    let(:task) { Task.create!(title: "Write section on testing mailers", size: 2) }

    it "does not send an email if a task is not completed" do
      patch :update, id: task.id, task: {size: 3}
      expect(ActionMailer::Base.deliveries.size).to eq(0) # <label id="code.no_emails" />
    end

    ##START:with_email
    it "sends email when task is completed" do
      patch :update, id: task.id, task: {size: 3, completed: true}
      task.reload  # <label id="code.reload" />
      expect(task.completed_at).to be_present
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      email = ActionMailer::Base.deliveries.first # <label id="code.check_email_start" />
      expect(email.subject).to eq("A task has been completed")
      expect(email.to).to eq(["monitor@tasks.com"])
      expect(email.body.to_s).to match(/Write section on testing mailers/)
    end
    ##END:with_email

  end
end

