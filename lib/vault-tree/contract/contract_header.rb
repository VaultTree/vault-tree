module VaultTree
  class ContractHeader
    def initialize(header_hash)
      @header_hash = header_hash
    end

    def to_hash
      @header_hash
    end
  end
end
