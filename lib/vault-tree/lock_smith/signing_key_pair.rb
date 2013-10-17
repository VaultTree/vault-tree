module VaultTree
  module LockSmith
    class SigningKeyPair

      def signing_key
        lib_signing_key.to_s(:base64)
      end

      def verify_key
        lib_verify_key.to_s(:base64)
      end

      private

      def lib_signing_key
        @lib_signing_key ||= Crypto::SigningKey.generate
      end

      def lib_verify_key
        lib_signing_key.verify_key
      end

    end
  end
end
