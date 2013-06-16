module VaultTree
  module LockSmith
    class EncryptionKeyPair
      def private_key
        lib_private_key.to_s(:base64)
      end

      def public_key
        lib_public_key.to_s(:base64)
      end

      private

      def lib_private_key
        @lib_private_key ||= Crypto::PrivateKey.generate
      end

      def lib_public_key
        lib_private_key.public_key
      end

    end
  end
end
