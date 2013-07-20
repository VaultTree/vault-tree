module VaultTree
  module V3
    class User
      attr_reader :user_id

      def initialize(opts)
        @user_id = opts[:user_id]
      end

      def address
        "#{user_id}@example.com"
      end

      def master_passphrase
        @master_passphrase ||= generate_key
      end

      def public_encryption_key
        @public_encryption_key ||= encryption_key_pair.public_key
      end

      def decryption_key
        @decryption_key ||= encryption_key_pair.private_key
      end

      def private_encryption_key
        @private_encryption_key ||= encryption_key_pair.private_key
      end

      def signing_key
        @signing_key ||= signing_key_pair.signing_key
      end

      def verification_key
        @verification_key ||= signing_key_pair.verify_key
      end

      def contract_consent_key
        @contract_consent_key ||= symmetric_cipher.generate_key
      end

      def generate_key
        LockSmith::SymmetricCipher.new.generate_key
      end

      def signing_key_pair
        @signing_key_pair ||= LockSmith::SigningKeyPair.new()
      end

      def encryption_key_pair
        @encryption_key_pair ||= LockSmith::EncryptionKeyPair.new()
      end

      def symmetric_cipher
        @symmetric_cipher ||= LockSmith::SymmetricCipher.new
      end

    end
  end
end
