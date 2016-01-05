module VaultTree
  module Expressions
    class ComputedPubKey
      def initialize(a)
        @a = a
      end
      attr_reader :a

      def evaluate(c, vault_id)
        LockSmith.new(private_key: plaintext_private_key(c, vault_id)).generate_public_key
      end

      def plaintext_private_key(c, vault_id)
        Expression.new(a).expression_object.evaluate(c, vault_id)
      end
    end
  end
end
