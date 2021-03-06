ENV["RACK_ENV"] = "test"

require "simplecov"
SimpleCov.start "rails"

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "capybara/rspec"
require "factory_girl_rails"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
end
