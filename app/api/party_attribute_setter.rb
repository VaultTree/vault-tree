module VaultTree
  module V1
    class PartyAttributeSetter < ContractModifier
      attr_reader :party_label, :attribute, :value

      def post_initialize(opts = {})
        @party_label = opts[:party_label]
        @attribute = opts[:attribute]
        @value = opts[:value]
      end

      def run
        contract.set_party_attribute(party_label, attribute, value)
        contract.reload
        contract.as_json
      end
    end
  end
end
