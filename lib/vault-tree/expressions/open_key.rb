module VaultTree
  module Expressions
    class OpenKey
      def initialize(a)
        @a = a
      end
      attr_reader :a

      # open_key is the way to create an unlocked vault
      # by locking with known insecure key, the vault contents
      # are available to all users of the collection
      def evaluate(c, vault_id)
        '0000000000000000000000000000000000000000000000000000000000000000'
      end
    end
  end
end
