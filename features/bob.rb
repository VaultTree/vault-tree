module VaultTree
  module AutoBots
    class Bob

      def take_contract(json)
        @contract_json = json 
      end

      def hand_over_contract
        contract_json
      end

      private
      attr_reader :contract_json

    end
  end
end
