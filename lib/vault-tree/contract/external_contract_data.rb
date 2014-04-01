module VaultTree
  class ExternalContractData
    def initialize(external_data_hash)
      @external_data_hash = external_data_hash
    end

    def update_data(h)
      @external_data_hash = h
    end

    def to_hash
      @external_data_hash
    end
  end
end
