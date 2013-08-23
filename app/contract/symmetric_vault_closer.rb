module VaultTree
  module V3
    class SymmetricVaultCloser
      attr_reader :vault

      def initialize(vault)
        @vault = vault
      end

      def close
        encrypt(vault.locking_key, vault.filler)
      end

      private

      def encrypt(key, plain_text)
        symmetric_cipher.encrypt(key: key, plain_text: plain_text)
      end

      def symmetric_cipher
        LockSmith::SymmetricCipher.new
      end
    end
  end
end
