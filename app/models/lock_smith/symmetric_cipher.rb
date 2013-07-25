module VaultTree
  module LockSmith
    class SymmetricCipher

      def generate_key
        Crypto::PrivateKey.generate.to_s(:base64)
      end

      def random_number
        sha rand(1000000000000)
      end

      def encrypt(opts = {})
        key = sha(opts[:key]) 
        plain_text = opts[:plain_text]
        box_from_key(key).box(plain_text, :base64)
      end

      def decrypt(opts = {})
        key = sha(opts[:key]) 
        cipher_text = opts[:cipher_text]
        box_from_key(key).open(cipher_text , :base64)
      end

      private

      def sha(data)
        Crypto::Hash.sha256("#{data}", :base64)
      end

      def box_from_key(key)
        sb = Crypto::SecretBox.new(key,:base64)
        rnb = Crypto::RandomNonceBox.new(sb)
      end
    end
  end
end
