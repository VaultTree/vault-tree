module VaultTree
  module V3
    class AsymmetricVaultCloser
      attr_reader :vault

      def initialize(vault)
        @vault = vault
      end

      def close
        asymmetric_encrypt(vault.locking_key, bob_decryption_key, vault.filler)
      end

      private

      def bob_decryption_key
        KeywordInterpreter.new("VAULT_CONTENTS['bob_decryption_key']",vault).evaluate
      end

      def asymmetric_encrypt(pub_key,priv_key,fill)
        asymmetric_cipher.encrypt(pub_key,priv_key,fill)
      end

      def asymmetric_cipher
        LockSmith::AsymmetricCipher.new
      end

    end
  end
end
