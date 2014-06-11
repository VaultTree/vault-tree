module VaultTree
  class Key < Keyword
    attr_reader :vault_id

    def post_initialize(arg_array)
      @vault_id = arg_array[0]
    end

    def evaluate
      LockSmith.new(message: raw_contents).secure_hash
    end

    private

    def raw_contents
      contract.open_vault(vault_id)
    end
  end
end
