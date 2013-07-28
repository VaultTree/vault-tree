module VaultTree
  module LockSmith
    class AsymmetricCipher

      def encrypt(public_key,private_key,plain_text)
        crypto_box(public_key,private_key).box(plain_text, :base64)
      end

      def decrypt(public_key,private_key,cipher_text)
        crypto_box(public_key,private_key).open(cipher_text, :base64)
      end

      private

      def crypto_box(public_key,private_key)
        pub = public_key_object(public_key)
        pri = private_key_object(private_key)
        box = Crypto::Box.new(pub,pri, :base64)
        Crypto::RandomNonceBox.new(box)
      end

      def private_key_object(pri_key)
        Crypto::PrivateKey.new(pri_key,:base64)
      end

      def public_key_object(pub_key)
        Crypto::PublicKey.new(pub_key,:base64)
      end
    end
  end
end
