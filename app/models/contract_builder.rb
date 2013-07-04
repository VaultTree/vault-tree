
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
    attr_reader :json_contract, :json_party_properties 

    def initialize(opts = {})
      @json_contract = opts[:json_contract]
      @json_party_properties = opts[:json_party_properties]
    end

    def build
      Support::JSON.encode(active_contract) 
    end

    private
    
    def active_contract
      new_contract = contract
      new_pps = party_properties
      party_id = new_pps['parties'].keys.first
      new_contract['parties'][party_id]['public_data'] = new_pps['parties'][party_id]['public_data']
      new_contract
    end

    def contract
      Support::JSON.decode(json_contract) 
    end

    def party_properties
      Support::JSON.decode(json_party_properties)
    end
  end
end
