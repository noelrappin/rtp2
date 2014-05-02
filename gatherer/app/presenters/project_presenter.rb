class ProjectPresenter < SimpleDelegator

  def self.from_project_list(*projects) # <label id="code.presenter_factory" />
    projects.flatten.map { |project| ProjectPresenter.new(project) }
  end

  def initialize(project) # <label id="code.presenter_constructor" />
    super
  end

  def name_with_status # <label id="code.presenter_method" />
    dom_class = on_schedule? ? 'on_schedule' : 'behind_schedule'
    "<span class='#{dom_class}'>#{name}</span>"
  end

end
