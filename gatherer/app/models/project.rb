class Project

  attr_accessor :tasks, :due_date

##START: velocity_length
  def self.velocity_length_in_days
    21
  end
##END:  velocity_length

  def initialize
    @tasks = []
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end


  def completed_velocity
    tasks.sum(&:points_toward_velocity)
  end

  ##START:current_rate
  def current_rate
    completed_velocity * 1.0 / Project.velocity_length_in_days
  end
  ##END:current_rate

  def projected_days_remaining
    remaining_size / current_rate
  end

  ##START:newer_math
  def on_schedule?
    return false if projected_days_remaining.nan?
    (Date.today + projected_days_remaining) <= due_date
  end
  ##END:new_math
end
