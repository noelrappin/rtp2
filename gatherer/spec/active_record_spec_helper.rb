require 'spec_helper'
require 'active_record'
require 'yaml'

connection_info = YAML.load_file("config/database.yml")["test"] # <label id="code.connection_info" />
ActiveRecord::Base.establish_connection(connection_info)

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do # <label id="code.rollback" />
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
