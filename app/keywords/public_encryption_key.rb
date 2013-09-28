module VaultTree
  class PublicEncryptionKey < Keyword
    attr_reader :vault_id

    def post_initialize(arg_array)
      @vault_id = arg_array[0]
    end

    def evaluate
      key_pair.public_key(decryption_key)
    end

    private

    def key_pair
      LockSmith::EncryptionKeyPair.new
    end

    def decryption_key
      contract.retrieve_contents(vault_id)
    end
  end
end
