module VaultTree
  module CLI
    class Checkout
      attr_reader :settings

      def initialize(settings)
        @settings = settings
      end

      def run(contract_name)
        settings.activate contract_name
      end
    end
  end
end
