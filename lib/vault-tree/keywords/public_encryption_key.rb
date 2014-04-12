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
      begin
        contract.retrieve_contents(vault_id)
      rescue Exceptions::EmptyVault => e
        raise Exceptions::MissingPartnerDecryptionKey.new(e, vault_id: vault_id )
      end
    end
  end
end
