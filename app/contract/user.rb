module VaultTree
  module V3
    class User
      attr_reader :user_id, :master_passphrase, :shared_contract_secret, :messages

      def initialize(opts = {})
        @user_id = opts[:user_id]
        @master_passphrase = opts[:master_passphrase]
        @shared_contract_secret = opts[:shared_contract_secret] 
        @messages = opts[:messages] 
      end

      def address
        "#{user_id}@example.com"
      end

      def public_encryption_key
        encryption_key_pair.public_key
      end

      def decryption_key
        encryption_key_pair.private_key
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

      def contract_consent_key
        symmetric_cipher.random_number
      end

      def generate_key
        symmetric_cipher.generate_key
      end

      private

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