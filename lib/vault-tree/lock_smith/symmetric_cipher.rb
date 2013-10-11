module VaultTree
  module LockSmith
    class SymmetricCipher

      def encrypt(opts = {})
        key = CryptoHash.compute(opts[:key])
        plain_text = opts[:plain_text]
        box_from_key(key).box(plain_text, :base64)
      end

      def decrypt(opts = {})
        key = CryptoHash.compute(opts[:key]) 
        cipher_text = opts[:cipher_text]
        box_from_key(key).open(cipher_text , :base64)
      end

      private

      def box_from_key(key)
        sb = Crypto::SecretBox.new(key,:base64)
        rnb = Crypto::RandomNonceBox.new(sb)
      end
    end
  end
end
