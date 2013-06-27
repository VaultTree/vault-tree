module VaultTree
  module V1
    class PartyAttributeValidator < ContractModifier
      attr_reader :party_label, :attribute

      def post_initialize(opts = {})
        @party_label = opts[:party_label]
        @attribute = opts[:attribute]
      end

      def valid_sigature?
        raise 'THIS METHOD NEEDS TO BE IMPLEMENTED'
        attribute_value = contract.party_attribute(attribute: attribute, party_label: party_label)
        verification_key = contract.party_attribute(attribute: :verification_key, party_label: party_label)
        digital_signature = contract.party_attribute_signature(party_label: party_label , attribute: attribute)
        puts verification_key
        verify_sig(verification_key, digital_signature, attribute_value)
      end

      private

      def verify_sig(verification_key, digital_signature, attribute_value)
        LockSmith::DigitalSignature.new(message: attribute_value, verify_key: verification_key, digital_signature: digital_signature).verify
      end
    end
  end
end
