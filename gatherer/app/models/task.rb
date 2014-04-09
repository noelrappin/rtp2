class Task

  attr_accessor :size, :completed_at

  def initialize(options = {})
    complete!(options[:completed]) if options[:completed]
    @size = options[:size]
  end

  def mark_completed
    @completed = true
  end

  def complete?
    !completed_at.nil?
  end

  def counts_toward_velocity?
    return false unless complete?
    completed_at > 3.weeks.ago
  end

  def points_toward_velocity
    if counts_toward_velocity? then size else 0 end
  end

end
