module VaultTree
  module V1
    class PartyAttributeSetter < ContractModifier
      attr_reader :party_label, :attribute 

      def post_initialize(opts = {})
        @party_label = opts[:party_label]
        @attribute = opts[:attribute]
      end

      def run
      end
    end
  end
end
