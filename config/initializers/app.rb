app = VaultTree::PathHelpers.app_dir
require_all "#{app}/models/**/*.rb"
require_all "#{app}/api/**/*.rb"
require_all "#{app}/presenters/**/*.rb"
require_all "#{app}/views/**/*.rb"
