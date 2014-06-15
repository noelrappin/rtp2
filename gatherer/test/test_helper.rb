ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails/capybara"
require "mocha/mini_test"

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  ##START:assert_select_string
  def assert_select_string(string, *selectors, &block)
    doc_root = HTML::Document.new(string).root
    assert_select(doc_root, *selectors, &block)
  end
  ##END:assert_select_string
end

##START: devise_helper
class ActionController::TestCase
  include Devise::TestHelpers
end
##END: devise_helper
