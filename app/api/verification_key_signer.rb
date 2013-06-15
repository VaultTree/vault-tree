module VaultTree
  module V1
    class VerificationKeySigner < ContractModifier
      attr_reader :party_label, :private_signing_key

      def post_initialize(opts = {})
        @party_label = opts[:party_label]
        @private_signing_key = opts[:private_signing_key]
      end

      def run
        contract.sign_verification_key(private_signing_key, party_label)
        contract.reload
        contract.as_json
      end
    end
  end
end
