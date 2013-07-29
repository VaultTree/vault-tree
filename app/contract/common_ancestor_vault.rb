module VaultTree
  module V3
    class CommonAncestorVault
      attr_reader :contract

      def initialize(contract)
        @contract = contract
      end

      def close_all_ancestors
        contract
      end
    end
  end
end
