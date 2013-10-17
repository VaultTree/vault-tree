module VaultTree
  class DecryptionKey < Keyword

    def evaluate
      key_pair.generate_private_key
    end

    private

    def key_pair
      LockSmith::EncryptionKeyPair.new
    end
  end
end
