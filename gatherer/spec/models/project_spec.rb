require 'spec_helper'

describe Project do

  ##START:let
  describe "with a new project" do
    let(:project) { Project.new }
    let(:task) { Task.new }

    it "knows that a project with no tasks is done" do
      expect(project).to be_done
    end

    it "knows that a project with an incomplete task is done" do
      project.tasks << task
      expect(project).not_to be_done
    end
  ##END:let

    describe "with a project that has one task" do
      before(:each) do
        project.tasks << Task.new
      end

      it "knows a project is only done if all its tests are done" do
        expect(project.done?).to be_falsy
        project.tasks.first.mark_completed
        expect(project.done?).to be_truthy
      end
    end

    #START:basic_stubs
    describe "with stubs" do
      it "can stub an instance and return a value" do
        project = Project.new(name: "Project Greenlight")
        allow(project).to receive(:name).and_return("Fred")
        expect(project.name).to eq("Fred")
      end

      it "can mock an instance and expect a value" do
        project = Project.new(name: "Project Greenlight")
        expect(project).to receive(:name).and_return("Fred")
        project.name
      end

      it "can spy on an instance" do
        project = Project.new(name: "Project Greenlight")
        allow(project).to receive(:name).and_return("Fred")
        project.name
        expect(project).to have_received(:name)
      end
    end
    #END:basic_stubs
  end

end
