module ProjectsHelper

  def name_with_status(project)
    content_tag(:span, project.name, class: 'on_schedule') # <label id="code.content_tag" />
  end
end
