module VaultTree
  module V3
    class SymmetricVaultOpener
      attr_reader :vault

      def initialize(vault)
        @vault = vault
      end

      def open
        symmetric_cipher.decrypt(key: vault.unlocking_key, cipher_text: vault.contents)
      end

      private

      def symmetric_cipher
        LockSmith::SymmetricCipher.new
      end

    end
  end
end
