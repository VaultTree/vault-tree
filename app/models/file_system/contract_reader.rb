module VaultTree
  module FileSystem
    class ContractReader
      attr_reader :path

      def initialize(path)
        @path = path
      end

      def read
        puts 'Reading in file at:'
        puts path
        '[]'
      end
    end
  end
end
