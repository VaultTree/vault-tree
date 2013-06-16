module VaultTree
  module V1
    class PartyAttributeSigner < ContractModifier
      attr_reader :party_label, :attribute, :private_signing_key

      def post_initialize(opts = {})
        @party_label = opts[:party_label]
        @attribute = opts[:attribute]
        @private_signing_key = opts[:private_signing_key]
      end

      def run
        contract.sign_party_attribute(attribute, party_label, private_signing_key)
        contract.reload
        contract.as_json
      end
    end
  end
end
