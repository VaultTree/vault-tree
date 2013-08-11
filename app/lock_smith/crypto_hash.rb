module VaultTree
  module LockSmith
    class CryptoHash

      def self.compute(data)
        Crypto::Hash.sha256("#{data}", :base64)
      end

    end
  end
end
