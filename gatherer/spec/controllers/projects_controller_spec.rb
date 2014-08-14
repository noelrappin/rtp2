require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  describe "POST create" do
    it "creates a project" do
      post :create, project: {name: "Runway", tasks: "Start somethig:2"} # <label id="code.call_post" />
      expect(response).to redirect_to(projects_path) # <label id="code.redirect" />
      expect(assigns(:action).project.name).to eq("Runway") # <label id="code.assigns" />
    end

    ##START:failure
    it "goes back to the form on failure" do
      post :create, project: {name: "", tasks: ""} # <label id="code.blank_form" />
      expect(response).to render_template(:new)
      expect(assigns(:project)).to be_present
    end
    ##END:failure
  end

end
