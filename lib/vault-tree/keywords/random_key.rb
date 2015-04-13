module VaultTree
  class RandomKey < Keyword

    def evaluate
      LockSmith.new().random_number
    end

  end
end
