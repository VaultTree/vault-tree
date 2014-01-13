module VaultTree
  class RandomNumber < Keyword

    def evaluate
      LockSmith.new().random_number
    end

  end
end
