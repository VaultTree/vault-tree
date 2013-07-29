module VaultTree
  module V3
    class SharedContractSecret < Keyword

      def evaluate
        contract.user_shared_contract_secret
      end

    end
  end
end
