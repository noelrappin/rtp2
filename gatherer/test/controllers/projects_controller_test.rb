require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase # <label id="code.inheritance" />

  ##START:setup
  setup do
    sign_in users(:user)
  end
  ##END:setup

  test "the index method displays all projects correctly" do
    on_schedule = Project.create!(due_date: 1.year.from_now,
        name: "On Schedule",
        tasks: [Task.create!(completed_at: 1.day.ago, size: 1)])
    behind_schedule = Project.create!(due_date: 1.day.from_now,
        name: "Behind Schedule",
        tasks: [Task.create!(size: 1)])
    get :index
    assert_select("#project_#{on_schedule.id} .on_schedule")
    assert_select("#project_#{behind_schedule.id} .behind_schedule")
  end

  ##START:post
  test "the project method creates a project" do
    post :create, project: {name: "Runway", tasks: "start something:2"} # <label id="code.mintest_call_post" />
    assert_redirected_to projects_path # <label id="code.controller_assert_redirect" />
    assert_equal "Runway", assigns[:action].project.name # <label id="code.assigns" />
  end
  ##END:post

  test "the project method creates a project (mock version)" do
    fake_project = mock(create: true)
    CreatesProject.expects(:new)
        .with(name: "Runway", task_string: "start something:2")
        .returns(fake_project)
    post :create, project: {name: "Runway", tasks: "start something:2"}
    assert_redirected_to projects_path
    refute_nil assigns[:action]
  end

  test "on failure we go back to the form" do
    post :create, project: {name: "", tasks: ""}
    assert_template :new
    refute_nil assigns(:project)
  end

  test "fail create gracefully" do
    assert_no_difference('Project.count') do
      Project.any_instance.expects(:save).returns(false)
      post :create, :project => {:name => 'Project Runway'}
      assert_template('new')
    end
  end

  test "fail update gracefully" do
    sample = Project.create!(name: "Test Project")
    Project.any_instance.expects(:update_attributes).returns(false)
    patch :update, id: projects(:one), project: {name: "Fred"}
    assert_template('edit')
    actual = Project.find(sample.id)
    assert_not_equal("Fred", actual.name)
  end

  test "let's stub a class again" do
    Project.stubs(:find).with(1).returns(
        Project.new(:name => "Project Greenlight"))
    Project.stubs(:find).with(2).returns(
        Project.new(:name => "Project Blue Book"))
    assert_equal("Project Greenlight", Project.find(1).name)
    assert_equal("Project Blue Book", Project.find(2).name)
  end

  test "routing" do
    assert_routing "/projects", controller: "projects", action: "index"
    assert_routing({path: "/projects", method: "post"},
        controller: "projects", action: "create")
    assert_routing "/projects/new", controller: "projects", action: "new"
    assert_routing "/projects/1", controller: "projects",
        action: "show", id: "1"
    assert_routing "/projects/1/edit", controller: "projects",
        action: "edit", id: "1"
    assert_routing({path: "/projects/1", method: "patch"},
        controller: "projects", action: "update", id: "1")
    assert_routing({path: "/projects/1", method: "delete"},
        controller: "projects", action: "destroy", id: "1")
  end

end
