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
      contract.merge(party_properties){|key, c_val, pp_val| c_val.merge(pp_val)}
    end

    def updated_parties
      contract['parties'].update(party_properties)
    end

    def contract
      @contract ||= Support::JSON.decode(json_contract) 
    end

    def party_properties
      @party_properties ||= Support::JSON.decode(json_party_properties)
    end
  end
end
