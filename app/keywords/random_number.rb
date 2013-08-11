module VaultTree
  module V3
    class RandomNumber < Keyword

      def evaluate
        LockSmith::RandomNumber.compute
      end

    end
  end
end
