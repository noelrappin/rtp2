RSpec::Matchers.define :have_size do |expected|
  match do |actual|
    size_to_check = @incomplete? actual.remaining_size : actual.total_size
    size_to_check == expected
  end

  description do
    "have tasks totaling #{expected} points"
  end

  failure_message do |actual|
    "expected project #{project.name} to have size #{actual}"
  end

  failure_message_when_negated do |actual|
    "expected project #{project.name} not to have size #{acutal}"
  end

  chain :for_incomplete_tasks_only do
    @incomplete = true
  end
end