require 'aruba/cucumber'

Given(/^a proper mruby setup$/) do
  VaultTree::Native::Setup.new().proper_setup? ? true : pending('SKIPPED. MRUBY ENV NOT SETUP PROPERLY.')
end

module VaultTree
  module Native
    class Setup
      def proper_setup?
        #inside_vagrant_vm? && mruby_dir_present? && mruby_exec_present?
        false
      end

      def inside_vagrant_vm?
        PathHelpers.project_parent_dir == '/vagrant'
      end

      def mruby_dir_present?
        File.exists?(PathHelpers.mruby_dir)
      end

      def mruby_exec_present?
        File.exists?(PathHelpers.mruby_exec)
      end
    end
  end
end
