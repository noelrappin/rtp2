RSpec::Matchers.define :have_size do |expected|
  match do |actual|
    actual.total_size == expected
  end
end
