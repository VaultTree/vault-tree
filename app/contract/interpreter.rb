module VaultTree
  module V3
    class Interpreter

      def close_vault_path(opts)
        vault_id = opts[:vault_id]
        contract = opts[:contract]
        user = opts[:user]

        contract.user = user 
        contract.close_vault_path(vault_id) 
      end

      def retrieve_contents(opts)
        vault_id = opts[:vault_id]
        contract = opts[:contract]
        user = opts[:user]

        contract.user = user 
        contract.retrieve_vault_contents(vault_id) 
      end

    end
  end
end
