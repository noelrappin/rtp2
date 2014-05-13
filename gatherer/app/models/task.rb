class Task < ActiveRecord::Base

  def self.complete
    where(["completed_at < ?", Time.current])
  end

  def mark_completed(date = nil)
    self.completed_at = (date || Time.current)
  end

  def complete?
    !completed_at.nil?
  end

  def counts_toward_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    if counts_toward_velocity? then size else 0 end
  end

  ##START:size_methods
  def epic?
    size >= 5
  end

  def small?
    size <= 1
  end
  ###END:size_methods

end
