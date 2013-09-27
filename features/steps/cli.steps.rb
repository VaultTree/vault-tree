require 'digest/sha1'

Given(/^the default settings file$/) do
  VaultTree::CLI::SettingsFile.new.write_default_settings_file
end

Then(/^the settings file should exists$/) do
  File.exists?(VaultTree::PathHelpers.spec_cli_settings_file).should be true
end

Given(/^an empty settings file$/) do
  VaultTree::CLI::SettingsFile.new.write_empty_settings_file
end

Given(/^a test contract file in the home dir with contents "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the active contract is "(.*?)"$/) do |arg1|
  file = VaultTree::CLI::SettingsFile.new.test_settings_path
  settings = VaultTree::CLI::Settings.new(file)
  settings.active_contract?(arg1).should be true
end

Given(/^I compute the contract checksum$/) do
  contents = File.read(VaultTree::PathHelpers.simple_test_contract)
  @starting_checksum = Digest::SHA1.hexdigest(contents)
end

Then(/^I can see the contract changes have been written to disk$/) do
  contents = File.read(VaultTree::PathHelpers.simple_test_contract)
  @finishing_checksum = Digest::SHA1.hexdigest(contents)
  @finishing_checksum.should_not == @starting_checksum
end

Given(/^a blank simple test contract$/) do
  clean_contract = VaultTree::PathHelpers.blank_simple_test_contract
  dirty_contract = VaultTree::PathHelpers.simple_test_contract
  FileUtils.cp(clean_contract,dirty_contract)
end
