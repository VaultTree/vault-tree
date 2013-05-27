module VaultTree
  module AutoBots
    class Bob
      def public_key
        key_pair.public_key
      end

      def private_key
        key_pair.private_key
      end

      private

      def key_pair
        @key_pair ||= LockSmith::KeyPair.new()
      end

    end
  end
end
