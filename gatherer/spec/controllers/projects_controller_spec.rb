require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:user) { User.create!(email: "rspec@example.com", password: "password") }

  ##START:setup
  before(:example) do
    sign_in(user)
  end
  ##END:setup

  describe "POST create" do
    ##START: state_test
    it "creates a project" do
      post :create, project: {name: "Runway", tasks: "Start something:2"}
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action).project.name).to eq("Runway")
    end
    ##END: state_test

    ##START:mocks
    it "creates a project (mock version)" do
      fake_action = instance_double(CreatesProject, create: true)
      expect(CreatesProject).to receive(:new)
          .with(name: "Runway", task_string: "Start something:2", users: [user])
          .and_return(fake_action)
      post :create, project: {name: "Runway", tasks: "Start something:2"}
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action)).not_to be_nil
    end
    ##END:mocks

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
      post :create, :project => {name: 'Project Runway'} # <label id="create_controller" />
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

    ##START:update
    it "does not allow user to make a project public if it is not theirs" do
      sample = Project.create!(name: "Test Project", public: false)
      patch :update, id: sample.id, project: {public: true}
      expect(sample.reload.public).to be_falsy
    end
    ##END:update
  end
  ##END: mock_update

  ##START:can_view
  describe "GET show" do
    let(:project) { Project.create(name: "Project Runway") }

    it "allows a user who is part of the project to see the project" do
      controller.current_user.stubs(can_view?: true)
      get :show, id: project.id
      expect(response).to render_template(:show)
    end

    it "does not allow a user who is not part of the project to see the project" do
      controller.current_user.stubs(can_view?: false)
      get :show, id: project.id
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  ##END:can_view

  ##START:index
  describe "GET index" do
    it "displays all projects correctly" do
      user = User.new
      project = Project.new(:name => "Project Greenlight")
      controller.expects(:current_user).returns(user)
      user.expects(:visible_projects).returns([project])
      get :index
      assert_equal assigns[:projects].map(&:__getobj__), [project]
    end
  end
  ##END:index

end
