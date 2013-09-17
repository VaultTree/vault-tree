module VaultTree
  class RandomNumber < Keyword

    def evaluate
      LockSmith::RandomNumber.compute
    end

  end
end
