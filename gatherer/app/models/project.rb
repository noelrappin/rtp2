class Project

  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  ##START: new_done
  def done?
    tasks.reject(&:complete?).empty?
  end
  ##END: new_done
end
