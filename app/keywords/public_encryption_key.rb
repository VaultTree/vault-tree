module VaultTree
  class PublicEncryptionKey < Keyword
    
    def evaluate
      contract.user_public_encryption_key
    end

  end
end
