module VaultTree
  module Support
    class DeserializedContract
      attr_reader :json_contract

      def initialize(json_contract)
        @json_contract = json_contract
      end

      def contract_hash
        JSON.decode(json_contract)
      end

      def signed_vault_content(opts = {})
        vault_with_label(opts[:vault_label])["signed_vault_content"] 
      end

      def vault_with_label(l)
        vaults.select{|v| v["label"] == l}.first
      end

      def vaults
        contract_hash["vaults"]
      end
    end
  end
end
