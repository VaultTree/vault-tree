module VaultTree
  module CLI
    class Checkout
      attr_reader :settings

      def initialize(settings)
        @settings = settings
      end

      def run(name)
        settings.activate_contract name
      end
    end
  end
end
