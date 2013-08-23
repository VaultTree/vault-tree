module VaultTree
  module V3
    class AsymmetricVaultCloser
      attr_reader :vault

      def initialize(vault)
        @vault = vault
      end

      def close
        asymmetric_cipher.encrypt(vault.locking_key, vault.asym_auth_key, vault.filler)
      end

      private

      def asymmetric_cipher
        LockSmith::AsymmetricCipher.new
      end

    end
  end
end
