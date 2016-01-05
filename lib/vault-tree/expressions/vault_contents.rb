module VaultTree
  module Expressions
    class VaultContents
      def initialize(a)
        @vault_id = a
      end

      attr_reader :vault_id

      def evaluate(c, id)
        collection.open_vault(vault_id, c)
      end

      def collection
        Collection.new
      end
    end
  end
end
