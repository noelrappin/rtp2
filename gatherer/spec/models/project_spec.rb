require 'rails_helper'

describe Project do

  describe "with a new project" do
    before(:each) do
      @project = Project.new
    end

    ##START:be_done
    it "knows that a project with no tasks is done" do
      expect(@project).to be_done
    end

    it "knows that a project with an incomplete task is done" do
      task = Task.new
      @project.tasks << task
      expect(@project).not_to be_done
    end
    ##END:be_done

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
