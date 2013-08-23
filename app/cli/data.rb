module VaultTree
  module CLI
    class Data
      attr_reader :settings

      def initialize(settings)
        @settings = settings
      end

      def add(name,path)
        settings.add_data(name,path)
        return 0
      end

      def list(arg_1 = nil,arg_2 = nil)
        if settings.list_data.empty?
          puts "No Data Files Registered"
        else
          puts settings.list_data
        end
        return 0
      end

      def show(name = nil,arg_2 = nil)
        data_path = settings.contents[:data][name]
        puts File.read(data_path)
        return 0
      end

      def rm(name = nil,arg_2 = nil)
        settings.rm_data(name)
        return 0
      end
    end
  end
end
