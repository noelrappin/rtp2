class Task

  def initialize
    @completed = false
  end

  def complete!
    @completed = true
  end

  def complete?
    @completed
  end

end
