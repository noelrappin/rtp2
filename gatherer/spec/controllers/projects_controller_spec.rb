require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  ##START:index
  describe "GET index" do
    it "displays all projects correctly" do
      on_schedule = Project.create!(due_date: 1.year.from_now,
          name: "On Schedule",
          tasks: [Task.create!(completed_at: 1.day.ago, size: 1)])
      behind_schedule = Project.create!(due_date: 1.day.from_now,
          name: "Behind Schedule",
          tasks: [Task.create!(size: 1)])
      get :index
      expect(response).to have_selector("#project_#{on_schedule.id} .on_schedule")
      expect(response).to have_selector("#project_#{behind_schedule.id} .behind_schedule")
    end
  end
  ##END:index

  describe "POST create" do
    it "creates a project" do
      post :create, project: {name: "Runway", tasks: "Start something:2"} # <label id="code.create_request" />
      expect(response).to redirect_to(projects_path) # <label id="code.controller_assert_redirect" />
      expect(assigns(:action).project.name).to eq("Runway")  # <label id="code.controller_assigns" />
    end

    it "creates a project (mock version)" do
      fake_action = instance_double(CreatesProject, create: true) # <label id="mock_project" />
      expect(CreatesProject).to receive(:new)  # <label id="mock_action" />
          .with(name: "Runway", task_string: "start something:2")
          .and_return(fake_action)
      post :create, project: {name: "Runway", tasks: "start something:2"}
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action)).not_to be_nil # <label id="mock_refute_nil" />
    end

    ##START:failure
    it "goes back to the form on failure" do
      post :create, project: {name: "", tasks: ""} # <label id="code.blank_form" />
      expect(response).to render_template(:new)
      expect(assigns(:project)).to be_present
    end
    ##END:failure

    ##START: mock_failure
    it "fails create gracefully" do
      action_stub = double(create: false, project: Project.new) # <label id="action_stub" />
      expect(CreatesProject).to receive(:new).and_return(action_stub) # <label id="create_any_instance" />
      post :create, :project => {:name => 'Project Runway'} # <label id="create_controller" />
      expect(response).to render_template(:new) # <label id="create_template" />
    end
    ##END: mock_failure

  end

  ##START: mock_update
  describe "PATCH update" do
    it "fails update gracefully" do
      sample = Project.create!(name: "Test Project")
      expect(sample).to receive(:update_attributes).and_return(false) # <label id="update_attributes" />
      allow(Project).to receive(:find).and_return(sample) # <label id="stub_find" />
      patch :update, id: sample.id, project: {name: "Fred"} # <label id="update_controller" />
      expect(response).to render_template(:edit) # <label id="update_template" />
    end
  end
  ##END: mock_update

end
