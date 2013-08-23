module VaultTree
  module CLI
    class Contract
      attr_reader :settings

      def initialize(settings)
        @settings = settings
      end

      def add(name,path)
        settings.add_contract(name,path)
        return 0
      end

      def list(arg_1 = nil,arg_2 = nil)
        if settings.list_contracts.empty?
          puts "No Contracts Registered"
        else
          puts list_contracts_with_color
        end
        return 0
      end

      def show(name = nil,arg_2 = nil)
        puts File.read(settings.active_contract_path)
        return 0
      end

      def rm(name = nil,arg_2 = nil)
        settings.rm_contract(name)
        return 0
      end

      private

      def contract_names
        settings.list_contracts
      end

      def list_contracts_with_color
        contract_names.map{|n| active_contract?(n) ? n.color(:green) : n.color(:white)}
      end

      def active_contract?(n)
        settings.active_contract?(n)
      end
    end
  end
end
