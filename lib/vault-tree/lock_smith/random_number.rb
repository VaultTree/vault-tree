module VaultTree
  module LockSmith
    class RandomNumber

      def self.compute
        CryptoHash.compute rand(1000000000000)
      end

    end
  end
end
