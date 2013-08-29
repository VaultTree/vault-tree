module VaultTree
  module V3
    class Contents < Keyword
      attr_reader :vault_id

      def post_initialize(vault_id)
        @vault_id = vault_id
      end

      def evaluate
        Vault.new(vault_id, contract).retrieve_contents
      end

    end
  end
end
