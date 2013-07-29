module VaultTree
  module V3
    class Message < Keyword
      attr_reader :arg 

      def post_initialize(arg)
        @arg = arg
      end

      def evaluate
        contract.user_messages(arg)
      end

    end
  end
end
