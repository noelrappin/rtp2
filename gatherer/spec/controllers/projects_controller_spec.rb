require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  describe "POST create" do
    it "creates a project" do
      post :create, project: {name: "Runway", tasks: "Start somethig:2"} # <label id="code.call_post" />
      expect(response).to redirect_to(projects_path) # <label id="code.redirect" />
      expect(assigns(:action).project.name).to eq("Runway") # <label id="code.spec_assigns" />
    end
  end

end
