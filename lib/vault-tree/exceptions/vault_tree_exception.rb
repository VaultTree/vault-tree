require 'erb'
module VaultTree
  module Exceptions
    class VaultTreeException < StandardError
      # WORK IN PROGRESS
      #
      #def self.exception
      #  self.present_exception
      #  self.new
      #end

      #def self.present_exception
      #  STDOUT.write template.result(binding)
      #end

      #def self.template
      #  ERB.new File.new(template_path).read, nil, "%"
      #end

      #def self.template_path
      #  "lib/vault-tree/exceptions/exception_template.erb"
      #end
    end
  end
end
