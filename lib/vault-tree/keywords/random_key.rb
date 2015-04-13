module VaultTree
  class RandomKey < Keyword

    def evaluate
      LockSmith.new().random_key
    end

  end
end
