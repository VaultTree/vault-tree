module VaultTree
  module V3
    class User
      attr_reader :external_data

      def initialize(opts = {})
        @master_passphrase = opts[:master_passphrase]
        @external_data = opts[:external_data] 
      end

      def master_passphrase
        raise Exceptions::MissingPassphrase if passphrase_missing?
        @master_passphrase
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

      def passphrase_missing?
        @master_passphrase.nil?
      end
    end
  end
end
