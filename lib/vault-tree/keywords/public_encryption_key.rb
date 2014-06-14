module VaultTree
  class PublicEncryptionKey < Keyword
    attr_reader :vault_id

    def post_initialize(arg_array)
      @vault_id = arg_array[0]
    end

    def evaluate
      LockSmith.new(private_key: decryption_key).generate_public_key
    end

    private

    def decryption_key
      contract.open_vault(vault_id)
    end
  end
end
