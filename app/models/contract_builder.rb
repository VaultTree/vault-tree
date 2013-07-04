
class Hash
  def branch_hashes
    hks = self.keys.select{|k| self[k].kind_of?(Hash) } # array of hashes
    hks.map{|k| {k => self[k]}}
  end

  def leaf_hashes
    hks = self.keys.select{|k| ! self[k].kind_of?(Hash) } # array of hashes
    hks.map{|k| {k => self[k]}}
  end
end

module VaultTree
  class ContractBuilder
    attr_reader :json_contract, :json_party_properties, :updated_contract

    def initialize(opts = {})
      @json_contract = opts[:json_contract]
      @json_party_properties = opts[:json_party_properties]
    end

    def build
      Support::JSON.encode(update_contract) 
    end

    private
   
    def party_id
      party_properties['parties'].keys.first
    end

    def public_data_given?
      !! party_properties['parties'][party_id]['public_data']
    end

    def private_data_given?
      !! party_properties['parties'][party_id]['private_data']
    end

    def update_public_data
      if public_data_given?
        @updated_contract['parties'][party_id]['public_data'] = party_properties['parties'][party_id]['public_data']
      end
    end

    def update_private_data
      if private_data_given?
        @updated_contract['parties'][party_id]['private_data'] = party_properties['parties'][party_id]['private_data']
      end
    end

    def update_contract
      fresh_contract
      update_public_data
      update_private_data
      updated_contract
    end

    def fresh_contract
      @updated_contract = contract.clone
    end

    def contract
      Support::JSON.decode(json_contract) 
    end

    def party_properties
      Support::JSON.decode(json_party_properties)
    end
  end
end
