module VaultTree
  class ContractValidator
    attr_reader :party_to_validate, :json_contract

    def initialize(opts = {})
      @json_contract = opts[:json_contract]
      @party_to_validate = opts[:party_to_validate]
    end

    def valid_signatures?
      raise 'IN THE PROCESS OF IMPLEMENTING'
      public_data_attrs.each do |attr|
        verify_signature( sig_for_attr(attr), value_for_attr(attr))
      end
    end

    private

    def verify_key
      party['public_data']['verification_key']
    end

    def sig_for_attr(attr)
      party['public_signatures'][attr]['signature']
    end

    def value_for_attr(attr)
      party['public_data'][attr]
    end

    def public_data_attrs
      party['public_data'].keys
    end

    def party
      contract['parties'][party_to_validate]
    end

    def contract
      Support::JSON.decode(json_contract) 
    end

    def verify_signature( signature, attribute_value)
      LockSmith::DigitalSignature.new(message: attribute_value, verify_key: verify_key, signature: signature).verify
    end
  end
end
