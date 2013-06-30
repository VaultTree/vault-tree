module VaultTree
  module Support
    class Contract
      attr_reader :json, :hash

      def initialize(json)
        @json = json 
      end

      def [](k)
        hash[k]
      end

      private

      def hash
        @hash = JSON.decode(json) 
      end
    end
  end
end
