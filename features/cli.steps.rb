Given(/^the default settings file$/) do
########################################
# READ IN SETTINGS


########################################
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
  file = VaultTree::CLI::SettingsFile.new.empty_settings_path
  settings = VaultTree::CLI::Settings.new(file)
  settings.active_contract?(arg1).should be true
end
