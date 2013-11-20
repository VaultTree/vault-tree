module VaultTree
  module LockSmith
    class SplitKey
      attr_reader :required_keys

      def initialize(opts)
        @required_keys = opts[:required_keys]
      end

      def generate
        CryptoHash.compute(key_digests.join(''))
      end

      private

      def key_digests
        required_keys.map{|k| CryptoHash.compute(k) }
      end

    end
  end
end
