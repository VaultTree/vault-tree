module VaultTree
  module V3
    class Keyword
     attr_reader :vault

      def initialize(vault, arg = nil)
        @vault = vault
        post_initialize(arg)
      end

      def contract
        vault.contract
      end

      def post_initialize(arg = nil)
        nil
      end
    end
  end
end
