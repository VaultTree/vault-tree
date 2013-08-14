module VaultTree
  module CLI
    class ContractPaths
      attr_reader :contract_settings

      def initialize(opts = {})
        @contract_settings = opts[:contract_settings]
      end

      def list
        STDOUT.puts names_with_color
        return 0 
      end

      def active_contract
        names.select{|n| contract_settings[n][:active]}.first
      end

      private

      def active_contract?(n)
        n == active_contract
      end

      def names
        contract_settings.keys
      end

      def names_with_color
        names.map{|n| active_contract?(n) ? n.to_s.color(:green) : n.to_s}
      end
    end
  end
end
