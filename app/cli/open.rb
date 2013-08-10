module VaultTree
  module CLI
    class Open < Command

      def execute
        puts retrieve_contents
        return 0
      end

      private

      def retrieve_contents
        interpreter.retrieve_contents(vault_id: vault_id, contract: contract, user: user)
      end
    end
  end
end
