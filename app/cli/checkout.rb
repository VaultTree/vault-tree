module VaultTree
  module CLI
    class Checkout
      attr_reader :settings

      def initialize(settings)
        @settings = settings
      end

      def run(name)
        settings.activate_contract name
        puts "Switching to contract: #{name.color(:green)}"
        return 0
      end
    end
  end
end
