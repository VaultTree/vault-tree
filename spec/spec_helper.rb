require_relative '../bin/vault-tree'
require 'rspec_encoding_matchers'

RSpec.configure do |config|
  config.color_enabled = true
  config.include RSpecEncodingMatchers
end

RSpec.configure do |config|
  config.mock_framework = :mocha
end
