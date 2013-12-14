require 'aruba/cucumber'

Given(/^a proper mruby setup$/) do
  VaultTree::NativeSetup.new().proper_setup? ? true : pending('SKIPPED. MRUBY NOT SETUP PROPERLY.')
end

module VaultTree
  class NativeSetup
    def proper_setup?
      false
    end
  end
end

