module VaultTree
  module V2
    class ContractModifier
      attr_reader :contract, :changes

      def initialize(opts)
        @contract = opts[:contract]
        @changes = opts[:changes]
        @modified_contract = contract.clone
      end

      def build
        update_public_data
        update_private_data
        modified_contract
      end

      private
      attr_reader :modified_contract

      def party_id
        changes['parties'].keys.first
      end

      def update_public_data
        modified_contract.write_public_data_for_party(party_id, public_data) if public_data_given?
      end

      def update_private_data
        modified_contract.write_private_data_for_party(party_id, private_data) if private_data_given?
      end

      def public_data
        changes['parties'][party_id]['public_data']
      end

      def private_data
        changes['parties'][party_id]['private_data']
      end

      def public_data_given?
        !! changes['parties'][party_id]['public_data']
      end

      def private_data_given?
        !! changes['parties'][party_id]['private_data']
      end
    end
  end
end
