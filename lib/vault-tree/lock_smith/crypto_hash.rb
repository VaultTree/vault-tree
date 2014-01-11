module VaultTree
  module LockSmith
    class CryptoHash

      def self.compute(data)
        RbNaCl::Hash.sha256 data
      end

    end
  end
end
