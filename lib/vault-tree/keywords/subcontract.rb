module VaultTree
  class Subcontract < Keyword
    attr_reader :sub_vaults

    def post_initialize(arg_array)
      @sub_vaults = arg_array
    end

    def evaluate
      Contract.new(sub_contract_json).as_json
    end

    private

    def sub_contract_json
      JSON.pretty_generate sub_contract_hash
    end

    def sub_contract_hash
      sub_contract_header.merge(sub_contract_vaults)
    end

    def sub_contract_header
      contract.header
    end

    def sub_contract_vaults
      {"vaults" => sub_contract_vaults_hash }
    end

    def sub_contract_vaults_hash
      h = {}; sub_vaults.each {|id| h[id] = subcontract_vault(id) }; h;
    end

    def subcontract_vault(id)
      contract.vaults[id]
    end
  end
end
