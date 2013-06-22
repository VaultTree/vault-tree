module VaultTree
  module V1
    class VaultCustodian < ContractModifier
      attr_reader :vault_label, :contents, :vault_key

      def post_initialize(opts = {})
        @vault_key = opts[:vault_key]
        @vault_label = opts[:vault_label]
        @contents = opts[:contents]
      end

      # Fills a vault with secret contents 
      #
      # @param contract [String] the input contract
      # @param [Hash] Required Options
      # @option opts [String] :vault_label target vault label
      # @option opts [String] :contents the contents to be placed in the vault
      # @return [String] The output contract
      def fill_vault
        # This is crap. Push this behavior down.
        v = contract.vault_with_label(vault_label)
        v.fill(contents)
        contract.reload
        contract.as_json
      end

      # Encrypts the vault contents with the provided symmetric key
      #
      # @param contract [String] the input contract
      # @param [Hash] Required Options
      # @option opts [String] :vault_label target vault label
      # @option opts [String] :encryption_key the key to lock the vault
      # @return [String] The output contract
      def lock_vault
        contract.lock_vault_with_label(vault_label: vault_label, vault_key: vault_key)
        contract.reload
        contract.as_json
      end

      def sign_vault
      end
    end
  end
end
