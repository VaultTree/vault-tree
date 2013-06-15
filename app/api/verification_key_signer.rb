module VaultTree
  module V1
    class VerificationKeySigner
      attr_reader :json, :party_label, :private_signing_key

      def initialize(json, opts = {})
        @json = json
        @party_label = opts[:party_label]
        @private_signing_key = opts[:private_signing_key]
      end

      def run
        contract.sign_verification_key(private_signing_key, party_label)
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
