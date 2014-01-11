module VaultTree
  module LockSmith
    class EncryptionKeyPair

      def generate_private_key
        RbNaCl::PrivateKey.generate.to_bytes
      end

      def public_key(pk)
        lib_public_key(pk).to_bytes
      end

      private

      def lib_private_key(s)
        RbNaCl::PrivateKey.new(s)
      end

      def lib_public_key(pk)
        lib_private_key(pk).public_key
      end

    end
  end
end
