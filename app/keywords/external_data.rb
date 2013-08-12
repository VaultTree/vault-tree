module VaultTree
  module V3
    class ExternalData < Keyword
      attr_reader :arg

      def post_initialize(arg)
        @arg = arg
      end

      def evaluate
      end

    end
  end
end
