module VaultTree
  class ContractPresenter
    attr_reader :contract

    def initialize(contract)
      @contract = contract
    end

    def as_json
      JSON.pretty_generate(contract_hash)
    end

    private

    def contract_hash
      {header: contract_header, vaults: contract_vaults}
    end

    def contract_header
      contract.header
    end

    def contract_vaults
      contract.vaults
    end
  end
end
