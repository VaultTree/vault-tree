require_relative '../config/initialize'

RSpec.configure do |config|
  config.color_enabled = true
  config.include RSpecEncodingMatchers
end

RSpec.configure do |config|
  config.mock_framework = :mocha
end

#RSpec.configure do |config|
#  config.before(:suite) do
#    VaultTree::DataBase.new().setup
#  end
#end
