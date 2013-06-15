module VaultTree
  module LockSmith
    class DigitalSignature
      attr_reader :signing_key, :verify_key, :message

      def initialize(opts = {})
        @message = opts[:message]
        @signing_key = opts[:signing_key]
        @verify_key = opts[:verify_key]
      end

      def generate
        sig_generator.sign(message, :base64)
      end

      def verify
        sig_verifier.verify(@message, :base64)
      end

      private

      def sig_generator
        Crypto::SigningKey.new(signing_key, :base64)
      end

      def sig_verifier
        Crypto::VerifyKey.new(verify_key, :base64)
      end
    end
  end
end
