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
          puts settings.list_contracts
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
    end
  end
end
