module VaultTree
  class SharedKey < Keyword
    attr_reader :public_key_vault_id, :secret_key_vault_id

    def post_initialize(arg_array)
      @public_key_vault_id = arg_array[0]
      @secret_key_vault_id = arg_array[1]
    end

    def evaluate
      SharedKeyPair.new(public_key: public_key_vault_contents, secret_key: secret_key_vault_contents)
    end

    private

    def public_key_vault_contents
      contract.retrieve_contents(public_key_vault_id)
    end

    def secret_key_vault_contents
      contract.retrieve_contents(secret_key_vault_id)
    end
  end
end
