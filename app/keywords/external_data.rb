module VaultTree
  class ExternalData < Keyword

    def evaluate
      contract.user_external_data(id)
    end

    def id
      vault.id
    end

  end
end
