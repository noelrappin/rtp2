RSpec::Matchers.define :have_size do |expected|
  match do |actual|
    actual.total_size == expected
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
end
