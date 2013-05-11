module VaultTree
  module Api
    module Contracts

      def self.enforce(opts = {})
        require_relative '../.vault-tree/templates/one_two_three'
        json = VaultTree::OneTwoThree.new.generate_contract
        contract = VaultTree::Contract.new(json)
        contract.enforce
        puts contract.log.show
      end

      def self.generate_contract
        require_relative '../.vault-tree/templates/one_two_three'
        puts VaultTree::OneTwoThree.new.generate_contract
      end

    end
  end
end
