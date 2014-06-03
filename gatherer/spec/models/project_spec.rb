require 'rails_helper'

describe Project do

  describe "with a new project" do
    before(:each) do
      @project = Project.new
    end

    it "knows that a project with no tasks is done" do
      expect(@project.done?).to be_truthy
    end

    it "knows that a project with an incomplete task is done" do
      task = Task.new
      @project.tasks << task
      expect(@project.done?).to be_falsy
    end
  end

end
