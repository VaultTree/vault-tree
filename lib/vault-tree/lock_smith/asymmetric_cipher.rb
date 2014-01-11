module VaultTree
  module LockSmith
    class AsymmetricCipher

      def encrypt(opts)
        crypto_box(opts[:public_key],opts[:secret_key]).box(opts[:plain_text])
      end

      def decrypt(opts)
        crypto_box(opts[:public_key],opts[:secret_key]).open(opts[:cipher_text])
      end

      private

      def crypto_box(public_key,private_key)
        pub = public_key_object(public_key)
        pri = private_key_object(private_key)
        box = RbNaCl::Box.new(pub,pri)
        RbNaCl::RandomNonceBox.new(box)
      end

      def private_key_object(pri_key)
        RbNaCl::PrivateKey.new(pri_key)
      end

      def public_key_object(pub_key)
        RbNaCl::PublicKey.new(pub_key)
      end
    end
  end
end
