require 'simplecov'

#un comment below to use Simple Cove
#SimpleCov.start

require_relative '../../config/initialize'
require 'aruba/cucumber'
require 'factory_girl_rails'
require_all VaultTree::PathHelpers.factories
