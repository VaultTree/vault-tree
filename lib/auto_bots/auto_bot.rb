module VaultTree
  module AutoBots
    class AutoBot

      def address
        "#{party_label}@auto_bot.com"
      end

      def public_encryption_key
        @public_encryption_key ||= encryption_key_pair.public_key
      end

      def decryption_key
        @decryption_key ||= encryption_key_pair.private_key
      end

      def private_encryption_key
        @private_encryption_key ||= encryption_key_pair.private_key
      end

      def signing_key
        @signing_key ||= signing_key_pair.signing_key
      end

      def verification_key
        @verification_key ||= signing_key_pair.verify_key
      end

      def contract_consent_key
        @contract_consent_key ||= encryption_key_pair.private_key
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

      def write_public_attrs(contract)
        my_public_attrs.each do |k,v|
          opts = { party_label: party_label, attribute: k, value: v }
          contract = VaultTree::V1::PartyAttributeSetter.new(contract, opts).run
        end
        return contract 
      end

      def sign_public_attrs(contract)
        my_public_attrs.each do |k,v|
          opts = {party_label: party_label, attribute: k}.merge(my_keys)
          contract = VaultTree::V1::PartyAttributeSigner.new(contract, opts).run
        end
        return contract
      end

      def sign_public_attributes(contract)
        VaultTree::ContractSigner.new(json_contract: contract).sign
      end

      def validate_public_attrs(contract, opts = {})
        contract = VaultTree::V1::PartyAttributeValidator.new(contract, opts).run
      end

      def my_public_attrs
        {
          label: party_label,
          public_encryption_key: public_encryption_key,
          verification_key: verification_key
        }
      end

      def write_public_attributes(contract)
        VaultTree::ContractBuilder.new(json_contract: contract, json_party_properties: public_data).build
      end

      def write_private_attributes(contract)
        VaultTree::ContractBuilder.new(json_contract: contract, json_party_properties: private_data).build
      end

      def my_keys
        {
          custodian_signing_key: signing_key,
          private_signing_key: signing_key
        }
      end

      def signing_key_pair
        @signing_key_pair ||= LockSmith::SigningKeyPair.new()
      end

      def encryption_key_pair
        @encryption_key_pair ||= LockSmith::EncryptionKeyPair.new()
      end

      def public_data
        %Q[
          {
            "parties":{
              "#{party_label}": {
                "public_data": {
                  "address": "#{address}",
                  "verification_key": "#{verification_key}",
                  "public_encryption_key": "#{public_encryption_key}",
                  "contract_consent_key": "#{contract_consent_key}"
                }
              }
            }
          }
        ]
      end

      def private_data
        %Q[
          {
            "parties":{
              "#{party_label}": {
                "private_data": {
                  "decryption_key": "#{decryption_key}",
                  "signing_key": "#{signing_key}"
                }
              }
            }
          }
        ]
      end

    end
  end
end
