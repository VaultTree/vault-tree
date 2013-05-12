require_relative '../config/initialize'
require 'rspec_encoding_matchers'
require 'factory_girl_rails'
require_all VaultTree::PathHelpers.factories

RSpec.configure do |config|
  config.color_enabled = true
  config.include RSpecEncodingMatchers
end

RSpec.configure do |config|
  config.mock_framework = :mocha
end

RSpec.configure do |config|
  config.before(:suite) do
    VaultTree::DataBase.new().setup
  end
end
