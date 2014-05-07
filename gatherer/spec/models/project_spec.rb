require 'spec_helper'

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

    describe "with a project that has one task" do
      before(:each) do
        @project.tasks << Task.new
      end

      it "knows a project is only done if all its tests are done" do
        expect(@project.done?).to be_falsy
        @project.tasks.first.mark_completed
        expect(@project.done?).to be_truthy
      end
    end
  end

end
