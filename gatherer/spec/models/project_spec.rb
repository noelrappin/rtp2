require 'rails_helper'

RSpec.describe Project do

  describe "initialization" do
    let(:project) { Project.new }
    let(:task) { Task.new }

    it "considers a project with no test to be done" do
      expect(project).to be_done
    end

    it "knows that a project with an incomplete test is not done" do
      project.tasks << task
      expect(project).not_to be_done
    end

    ##START:third_spec
    it "marks a project done if its tasks are done" do
      project.tasks << task
      task.mark_completed
      expect(project).to be_done
    end
    ##END:third_spec
  end
end

