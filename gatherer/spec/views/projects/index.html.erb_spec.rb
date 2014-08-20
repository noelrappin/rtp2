require 'rails_helper'

describe "projects/index" do
  let(:completed_task) { Task.create!(completed_at: 1.day.ago, size: 1) }
  let(:on_schedule) { Project.create!(
      due_date: 1.year.from_now, name: "On Schedule", tasks: [completed_task]) }

  it "renders the index page with correct dom elements" do
    @projects = [on_schedule]
    render
    expect(rendered).to have_selector( "#project_#{on_schedule.id}")
  end
end
