module VaultTree
  module Expressions
    class RandomKey
      def initialize(a)
        @a = a
      end
      attr_reader :a

      def evaluate(c, vault_id)
        LockSmith.new.generate_secret_key
      end
    end
  end
end
