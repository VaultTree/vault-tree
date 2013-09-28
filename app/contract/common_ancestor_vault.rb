module VaultTree
  class CommonAncestorVault
    attr_reader :contract

    def initialize(contract)
      @contract = contract
    end

    def close
      contract
    end
  end
end
