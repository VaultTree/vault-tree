require_relative '../config/initialize'
require 'rspec_encoding_matchers'
require 'factory_girl_rails'

RSpec.configure do |config|
  config.color_enabled = true
  config.include RSpecEncodingMatchers
end

RSpec.configure do |config|
  config.mock_framework = :mocha
end
