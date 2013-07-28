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

      def public_encryption_key
        encryption_key_pair.public_key
      end

      def decryption_key
        encryption_key_pair.private_key
      end

      private

      def encryption_key_pair
        @encryption_key_pair ||= LockSmith::EncryptionKeyPair.new()
      end

      def symmetric_cipher
        @symmetric_cipher ||= LockSmith::SymmetricCipher.new
      end

    end
  end
end
