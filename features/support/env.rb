require 'simplecov'

#un comment below to use Simple Cove
#SimpleCov.start

require_relative '../../config/initialize'
require 'aruba/cucumber'
require 'factory_girl_rails'
require_all VaultTree::PathHelpers.factories

Before do
  cmd = "alias vault-tree='#{VaultTree::PathHelpers.cli_executable}'"
  `#{cmd}`
end

Before do
  @dirs = ["#{VaultTree::PathHelpers.practice_config_dir}"]
end

Before do
  VaultTree::CLI::SettingsFile.new.delete_test_settings_file
end

After do
  VaultTree::CLI::SettingsFile.new.delete_test_settings_file
end
