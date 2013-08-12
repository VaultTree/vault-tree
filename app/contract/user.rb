module VaultTree
  module V3
    class User
      attr_reader :master_passphrase, :external_data

      def initialize(opts = {})
        @master_passphrase = opts[:master_passphrase]
        @external_data = opts[:external_data] 
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
