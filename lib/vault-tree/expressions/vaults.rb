module VaultTree
  module Expressions
    class Vaults
      def initialize(a)
        @vault_ids = a
      end
      attr_reader :vault_ids

      # returns a JSON object of the specified vaults to be 'nested'
      # this JSON string is then locked in the specified vault
      #
      # the locked vault collection is itself a valid VaultTree collection
      #
      # the ability to nest collections of vaults within other vaults
      # is a powerful feature of the library
      def evaluate(c, vault_id)
        nested_vaults = {'vaults' => {}}
        vault_ids.each do |id|
          nested_vaults['vaults'][id] = c['vaults'][id]
        end
        JSON.pretty_generate(nested_vaults)
      end
    end
  end
end
