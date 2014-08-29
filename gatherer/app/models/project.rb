class Project < ActiveRecord::Base
  has_many :tasks, -> { order "project_order ASC" }

  ##START:roles
  has_many :roles
  has_many :users, through: :roles
  ##END:roles

  validates :name, presence: true

  ##START:public
  def self.all_public
    where(public: true)
  end
  ##END:public

  def total_size
    tasks.to_a.sum(&:size)
  end

  def size
    total_size
  end

  def remaining_size
    incomplete_tasks.to_a.sum(&:size)
  end

  def completed_velocity
    tasks.to_a.sum(&:points_toward_velocity)
  end

  def self.velocity_length_in_days
    21
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def current_rate
    completed_velocity * 1.0 / Project.velocity_length_in_days
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def undefined_rate?
    current_rate == 0
  end

  def on_schedule?
    return false if undefined_rate?
    (Date.today + projected_days_remaining) <= due_date
  end

  ##START: next_task_order
  def next_task_order
    return 1 if tasks.empty?
    (tasks.last.project_order || tasks.size) + 1
  end
  ##END: next_task_order

  ##START:add_users
  def add_users(users)
    users << users
  end
  ##END:add_users

end
