module VaultTree
  class SharedKey < Keyword
    attr_reader :public_key_vault_id, :secret_key_vault_id

    def post_initialize(arg_array)
      @public_key_vault_id = arg_array[0]
      @secret_key_vault_id = arg_array[1]
    end

    def evaluate
    end
  end
end
