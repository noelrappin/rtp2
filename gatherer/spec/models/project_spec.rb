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

    it "marks a project done if its tasks are done" do
      project.tasks << task
      task.mark_completed
      expect(project).to be_done
    end

    it "properly estimates a blank project" do
      expect(project.completed_velocity).to eq(0)
      expect(project.current_rate).to eq(0)
      expect(project.projected_days_remaining.nan?).to be_truthy
      expect(project).not_to be_on_schedule
    end
  end

  describe "estimates" do
    let(:project) { Project.new }
    let(:newly_done) { Task.new(size: 3, completed_at: 1.day.ago) }
    let(:old_done) { Task.new(size: 2, completed_at: 6.months.ago) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    before(:each) do
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end

    ##START: matcher_chained
    it "can calculate total size" do
      expect(project).to be_of_size(10)
      expect(project).to be_of_size(5).for_incomplete_tasks_only
    end
    ##END: matcher_chained

    it "can calculate remaining size" do
      expect(project.remaining_size).to eq(5)
    end

    it "knows its velocity" do
      expect(project.completed_velocity).to eq(3)
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7)
    end

    it "knows its projected time remaining" do
      expect(project.projected_days_remaining).to eq(35)
    end

    it "knows if it is on schedule" do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end
  end

  ##START:stub_one
  it "stubs an object" do
    project = Project.new(name: "Project Greenlight")
    allow(project).to receive(:name) # <label id="stub_one_stub" />
    expect(project.name).to be_nil # <label id="stub_one_assert" />
  end
  ##END:stub_one

  ##START:stub_two
  it "stubs an object again" do
    project = Project.new(name: "Project Greenlight")
    allow(project).to receive(:name).and_return("Fred") # <label id="stub_two_stub" />
    expect(project.name).to eq("Fred") # <label id="stub_two_assert" />
  end
  ##END:stub_two

  ##START: stub_class
  it "stubs the class" do
    allow(Project).to receive(:find).and_return(
        Project.new(name: "Project Greenlight"))
    project = Project.find(1) # <label id="stub_class_stub" />
    expect(project.name).to eq("Project Greenlight")
  end
##END:  stub_class

##START: mock_one
  it "mocks an object" do
    mock_project = Project.new(name: "Project Greenlight")
    expect(mock_project).to receive(:name).and_return("Fred")
    expect(mock_project.name).to eq("Fred")
  end
##END:  mock_one

##START: multi_return
  it "stubs with multiple returns" do
    project = Project.new
    allow(project).to receive(:user_count).and_return(1, 2)
    assert_equal(1, project.user_count)
    assert_equal(2, project.user_count)
    assert_equal(2, project.user_count)
  end
##END:  multi_return

end

