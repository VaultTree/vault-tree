module VaultTree
  class DecryptionKey < Keyword

    def evaluate
      LockSmith.new().generate_private_key
    end

  end
end
