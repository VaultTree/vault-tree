module VaultTree
  class ContractSigner
    attr_reader :json_contract

    def initialize(opts = {})
      @json_contract = opts[:json_contract]
    end

    def sign
      Support::JSON.encode(sign_contract) 
    end

    private
    attr_accessor :signed_contract 

    def sign_contract
      fresh_contract
      write_public_data_signatures
      signed_contract
    end

    def write_public_data_signatures
      public_data_attributes.each{|pda| write_public_data_signature(pda)}
    end

    def write_public_data_signature(attr)
      @signed_contract['parties'][party_id]['public_signatures'][attr]['signature'] = generate_signature(attr, signing_key)
    end

    def generate_signature(msg, sk)
      LockSmith::DigitalSignature.new(message: msg, signing_key: sk).generate
    end

    def public_data_value(attribute)
      eval("contract#{contract['parties'][party_id]['public_signatures'][attribute]['source']}")
    end

    def public_data_attributes
      public_data.keys
    end

    def public_data
      contract['parties'][party_id]['public_data']
    end

    def signing_key
      contract['parties'][party_id]['private_data']['signing_key']
    end

    def party_id
      party_ids.select{|p_id| parties[p_id]['private_data']['signing_key'].non_empty?}.first
    end

    def party_ids
      parties.keys
    end

    def parties
      contract['parties']
    end

    def public_signatures
      contract['parties'][party_id]['public_signatures']
    end

    def fresh_contract
      @signed_contract = contract.clone
    end

    def contract
      Support::JSON.decode(json_contract) 
    end
  end
end

class String
  def non_empty?
    ! empty?
  end
end
