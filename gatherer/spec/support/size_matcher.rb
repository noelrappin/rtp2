RSpec::Matchers.define :have_size do |expected|
  match do |actual|
    actual.size == expected
  end
end
