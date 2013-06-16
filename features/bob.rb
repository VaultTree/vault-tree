module VaultTree
  module AutoBots
    class Bob

      def public_encryption_key
        encryption_key_pair.public_key
      end

      def private_encryption_key
        encryption_key_pair.private_key
      end

      def signing_key
        signing_key_pair.signing_key
      end

      def verification_key
        signing_key_pair.verify_key
      end

      private

      def signing_key_pair
        @signing_key_pair ||= LockSmith::SigningKeyPair.new()
      end

      def encryption_key_pair
        @encryption_key_pair ||= LockSmith::EncryptionKeyPair.new()
      end
    end
  end
end
