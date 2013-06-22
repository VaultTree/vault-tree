module VaultTree
  module LockSmith
    class SymmetricCipher

      def generate_key
        Crypto::PrivateKey.generate.to_s(:base64)
      end

      def encrypt(opts = {})
        box_from_key(opts[:key]).box(opts[:plain_text], :base64)
      end

      def decrypt(opts = {})
        box_from_key(opts[:key]).open(opts[:cipher_text], :base64)
      end

      private

      def box_from_key(key)
        sb = Crypto::SecretBox.new(key,:base64)
        rnb = Crypto::RandomNonceBox.new(sb)
      end
    end
  end
end
