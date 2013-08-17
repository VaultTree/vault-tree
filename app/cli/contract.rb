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
        puts settings.list_contracts
        return 0
      end

      def show(name = nil,arg_2 = nil)
        puts name
        puts read(settings.contract_path(name))
        return 0
      end

      def rm(name = nil,arg_2 = nil)
        settings.rm_contract(name)
        return 0
      end

      private

      def read(d)
        File.read(d)
      end
    end
  end
end
