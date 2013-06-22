module VaultTree
  module V1
    class VaultCustodian < ContractModifier
      attr_reader :vault_label, :content, :vault_key, :custodian_signing_key

      def post_initialize(opts = {})
        @vault_key = opts[:vault_key]
        @vault_label = opts[:vault_label]
        @content = opts[:content]
        @custodian_signing_key = opts[:custodian_signing_key]
      end

      # Fills a vault with content
      #
      # @param contract [String] the input contract
      # @param [Hash] Required Options
      # @option opts [String] :vault_label target vault label
      # @option opts [String] :content the contents to be placed in the vault
      # @return [String] The output contract
      def fill_vault
        contract.fill_vault_with_label(vault_label: vault_label, content: content)
        contract.reload
        contract.as_json
      end

      # Encrypts the vault contents with the provided symmetric key
      #
      # @param contract [String] the input contract
      # @param [Hash] Required Options
      # @option opts [String] :vault_label target vault label
      # @option opts [String] :vault_key the key to lock the vault
      # @return [String] The output contract
      def lock_vault
        contract.lock_vault_with_label(vault_label: vault_label, vault_key: vault_key)
        contract.reload
        contract.as_json
      end


      # Generate a digital signature for the vault content
      #
      # @param contract [String] the input contract
      # @param [Hash] Required Options
      # @option opts [String] :vault_label target vault label
      # @option opts [String] :custodian_signing_key the signing key of the custodian party
      # @return [String] The output contract
      def sign_vault
        contract.sign_vault_with_label(vault_label: vault_label, custodian_signing_key: custodian_signing_key)
        contract.reload
        contract.as_json
      end
    end
  end
end
