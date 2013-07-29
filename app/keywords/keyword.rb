module VaultTree
  module V3
    class Keyword
     attr_reader :contract

      def initialize(contract, arg = nil)
        @contract = contract
        post_initialize(arg)
      end

      def post_initialize(arg = nil)
        nil
      end
    end
  end
end
