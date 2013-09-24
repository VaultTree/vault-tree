module VaultTree
  class Contents < Keyword
    attr_reader :vault_id

    def post_initialize(arg_array)
      @vault_id = arg_array[0]
    end

    def evaluate
      Vault.new(vault_id, contract).retrieve_contents
    end
  end
end
