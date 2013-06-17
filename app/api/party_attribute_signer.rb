module VaultTree
  module V1
    class PartyAttributeSigner < ContractModifier
      attr_reader :party_label, :attribute, :private_signing_key

      def post_initialize(opts = {})
        @party_label = opts[:party_label]
        @attribute = opts[:attribute]
        @private_signing_key = opts[:private_signing_key]
      end

      # Signs the respective party's public attributes
      #
      # @param contract [String] the input contract
      # @param [Hash] Required Options
      # @option opts [String] :party_label
      #   The label associated with the particular party.
      # @option opts [String] :attribute the party attribute to be signed
      # @option opts [String] :private_signing_key Digital Signature private signing key
      #
      #   In the real world, signatures help uniquely identify people because everyone's signature
      #   is unique. Digital signatures work similarly in that they are unique to holders of a
      #   private key, but unlike real world signatures, digital signatures are unforgable.
      #
      #   Digital signatures allow you to publish a public key, then you can use your
      #   private signing key to sign messages. Others who have your public key can then
      #   use it to validate that your messages are actually authentic.
      # @return [String] The output contract
      def run
        contract.sign_party_attribute(attribute, party_label, private_signing_key)
        contract.reload
        contract.as_json
      end
    end
  end
end
