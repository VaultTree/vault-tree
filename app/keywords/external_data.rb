module VaultTree
  class ExternalData < Keyword

    def evaluate
      contract.user_external_data(vault_id)
    end

    def vault_id
      vault.vault_id
    end

  end
end
