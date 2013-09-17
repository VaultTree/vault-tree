module VaultTree
  class ExternalData < Keyword
    attr_reader :arg

    def post_initialize(arg)
      @arg = arg
    end

    def evaluate
      contract.user_external_data(vault_id)
    end

    def vault_id
      vault.vault_id
    end

  end
end
