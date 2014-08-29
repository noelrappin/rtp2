require "minitest/autorun"
require "mocha/mini_test"
require 'active_record'
require 'active_support/test_case'
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use!(
  [Minitest::Reporters::DefaultReporter.new(reporter_options)])

connection_info = YAML.load_file("config/database.yml")["test"]
ActiveRecord::Base.establish_connection(connection_info)

module ActiveSupport
  class TestCase
    teardown do
      ActiveRecord::Base.subclasses.each(&:delete_all)
    end
  end
end
