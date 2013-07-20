app = VaultTree::PathHelpers.app_dir
require_all "#{app}/models/**/*.rb"
require_all "#{app}/v2_models/**/*.rb"
require_all "#{app}/api/**/*.rb"
require_all "#{app}/contract/**/*.rb"
require_all "#{app}/serializers/**/*.rb"
require_all "#{app}/deserializers/**/*.rb"
