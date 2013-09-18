module VaultTree
  module LockSmith
    class EncryptionKeyPair

      def generate_private_key
        Crypto::PrivateKey.generate.to_s(:base64)
      end

      def public_key(pk)
        lib_public_key(pk).to_s(:base64)
      end

      private

      def lib_private_key(s)
        Crypto::PrivateKey.new(s,:base64)
      end

      def lib_public_key(pk)
        lib_private_key(pk).public_key
      end

    end
  end
end
