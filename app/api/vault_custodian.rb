module VaultTree
  module V1
    class VaultCustodian < ContractModifier
      attr_reader :vault_label, :contents

      def post_initialize(opts = {})
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
      end

      def sign_vault
      end
    end
  end
end
