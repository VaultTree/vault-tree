module VaultTree
  module LockSmith
    class SymmetricCipher
      attr_reader :hash_class

      def initialize
        @hash_class = CryptoHash
      end

      def encrypt(opts = {})
        key_hash = compute_hash(opts[:key])
        plain_text = opts[:plain_text]
        box_from_key(key_hash).box(plain_text)
      end

      def decrypt(opts = {})
        key_hash = compute_hash(opts[:key])
        cipher_text = opts[:cipher_text]
        box_from_key(key_hash).open(cipher_text)
      end

      private

      def box_from_key(key)
        RbNaCl::RandomNonceBox.from_secret_key(key)
      end

      def compute_hash(str)
        hash_class.compute(str)
      end
    end
  end
end
