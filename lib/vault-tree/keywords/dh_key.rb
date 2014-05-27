module VaultTree
  class DhKey < Keyword
    attr_reader :public_key_vault_id, :secret_key_vault_id

    def post_initialize(arg_array)
      @public_key_vault_id = arg_array[0]
      @secret_key_vault_id = arg_array[1]
    end

    def evaluate
      DHKeyPair.new(public_key: public_key_vault_contents, secret_key: secret_key_vault_contents)
    end

    private

    def public_key_vault_contents
      contract.open_vault(public_key_vault_id)
    end

    def secret_key_vault_contents
      contract.open_vault(secret_key_vault_id)
    end
  end
end
