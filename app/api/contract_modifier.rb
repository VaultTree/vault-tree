module VaultTree
  module V1
    class ContractModifier
      attr_reader :json

      def initialize(json, opts = {})
        @json = json
        post_initialize(opts)
      end

      def post_initialize(opts = {})
        nil
      end

      private

      def contract
        @contract ||= VaultTree::Contract.import(json)
      end
    end
  end
end
