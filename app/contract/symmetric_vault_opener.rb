module VaultTree
  module V3
    class SymmetricVaultOpener
      attr_reader :vault

      def initialize(vault)
        @vault = vault
      end

      def open
        decrypt(vault.unlocking_key, vault.contents)
      end

      private

      def decrypt(key,cipher_text)
        symmetric_cipher.decrypt(key: key, cipher_text: cipher_text)
      end

      def symmetric_cipher
        LockSmith::SymmetricCipher.new
      end

    end
  end
end
