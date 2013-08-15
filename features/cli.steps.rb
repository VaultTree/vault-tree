Given(/^the default settings file$/) do
########################################
# READ IN SETTINGS

SETTINGS_FILE = File.expand_path('~/projects/vault-tree/vault-tree/spec/support/cli/.vt')
settings = {password: nil, contracts: {}, data: {}}

if File.exists? SETTINGS_FILE
  file_contents = YAML.load_file(SETTINGS_FILE)
  settings.merge!(file_contents)
else
  File.open(SETTINGS_FILE , 'w') {|f| YAML::dump(options,f) }
  STDERR.puts "Initialized settings file in #{SETTINGS_FILE }"
end

########################################
end

Then(/^the settings file should exists$/) do
  File.exists?(VaultTree::PathHelpers.spec_cli_settings_file).should be true
end
