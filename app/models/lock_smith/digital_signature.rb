module VaultTree
  module LockSmith
    class DigitalSignature
      attr_reader :signing_key, :verify_key, :message

      ENCODING = :hex

      def initialize(opts = {})
        @message = opts[:message]
        @signing_key = opts[:signing_key]
        @verify_key = opts[:verify_key]
      end

      def generate
        sig_generator.sign(@message, ENCODING)
      end

      def verify
        sig_verifier.verify(@message, ENCODING)
      end

      private

      def sig_generator
        Crypto::SigningKey.new(signing_key, ENCODING)
      end

      def sig_verifier
        Crypto::VerifyKey.new(verify_key, ENCODING)
      end
    end
  end
end
