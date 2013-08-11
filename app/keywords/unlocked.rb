module VaultTree
  module V3
    class Unlocked < Keyword

      def evaluate
        LockSmith::CryptoHash.compute('UNLOCKED')
      end

    end
  end
end
