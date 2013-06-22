module VaultTree
  module AutoBots
    class Bob

      def public_encryption_key
        encryption_key_pair.public_key
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

      def fill_lock_sign_vault(contract, opts = {})
        opts = opts.merge(my_keys)
        contract = V1::VaultCustodian.new(contract, opts).fill_vault
        contract = V1::VaultCustodian.new(contract, opts).lock_vault
        contract = V1::VaultCustodian.new(contract, opts).sign_vault
      end

      def generate_key
        LockSmith::SymmetricCipher.new.generate_key
      end

      private

      def my_keys
        {
          custodian_signing_key: signing_key
        }
      end


      def signing_key_pair
        @signing_key_pair ||= LockSmith::SigningKeyPair.new()
      end

      def encryption_key_pair
        @encryption_key_pair ||= LockSmith::EncryptionKeyPair.new()
      end
    end
  end
end
