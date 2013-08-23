module VaultTree
  module V3
    class AsymmetricVaultOpener
      attr_reader :vault

      def initialize(vault)
        @vault = vault
      end

      def open
        cipher_text = vault.contents
        key = vault.unlocking_key 
        pub_key = KeywordInterpreter.new("VAULT_CONTENTS['bob_public_encryption_key']", vault).evaluate
        asymmetric_decrypt(pub_key,key,cipher_text)
      end

      private

      def asymmetric_cipher
        LockSmith::AsymmetricCipher.new
      end

      def asymmetric_decrypt(pub_key,priv_key,cipher_text)
        asymmetric_cipher.decrypt(pub_key,priv_key,cipher_text)
      end
    end
  end
end
