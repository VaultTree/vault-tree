module VaultTree
  class ExternalData < Keyword

    def evaluate
      contract.external_data(id)
    end

    def id
      vault.id
    end

  end
end
