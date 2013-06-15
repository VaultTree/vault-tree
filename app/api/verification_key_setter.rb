module VaultTree
  module V1
    class VerificationKeySetter < ContractModifier
      attr_reader :json, :party_label, :verification_key

      def initialize(json, opts = {})
        @json = json
        @party_label = opts[:party_label]
        @verification_key = opts[:verification_key]
      end

      def run
        contract.set_verification_key(verification_key, party_label)
        contract.save!
        contract.reload
        contract.as_json
      end

      private

      def contract
        @contract ||= VaultTree::Contract.import(json)
      end
    end
  end
end
