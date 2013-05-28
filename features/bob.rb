module VaultTree
  module AutoBots
    class Bob
      def public_key
        key_pair.public_key
      end

      def private_key
        key_pair.private_key
      end

      def verification_key
        public_key.to_s
      end

      def private_signing_key
        private_key.to_s
      end

      def public_encryption_key
        'BOBS_PUBLIC_ENCRYPTION_KEY'
      end

      private

      def key_pair
        @key_pair ||= LockSmith::KeyPair.new()
      end

    end
  end
end
