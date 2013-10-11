module VaultTree
  class Unlocked < Keyword

    def evaluate
      LockSmith::CryptoHash.compute('UNLOCKED')
    end

  end
end
