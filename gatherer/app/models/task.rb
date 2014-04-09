##START:as_active_record
class Task < ActiveRecord::Base
##END:as_active_record

  def self.complete
    where("completed_at IS NOT NULL")
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

end
