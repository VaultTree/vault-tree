module VaultTree
  class DecryptionKey < Keyword

    def evaluate
      contract.user_decryption_key 
    end

  end
end
