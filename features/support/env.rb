require_relative '../../config/initialize'
require 'aruba/cucumber'
require 'factory_girl_rails'
require_all VaultTree::PathHelpers.factories
#require "#{VaultTree::PathHelpers.spec_helper}"

Before do 
  if !$dunit 
    # Setup Database
    VaultTree::DataBase.new().setup
    $dunit = true 
  end 
end
