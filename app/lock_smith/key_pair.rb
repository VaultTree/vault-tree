module VaultTree
  module LockSmith
    class KeyPair
      def initialize
      end

      def private_key
        @private_key ||= PrivateKey.new
      end

      def public_key
        @public_key ||= PublicKey.new(private_key)
      end
    end

    class PartyKey
      def to_s
        HexEncoder.new.encode(rbnacl_key.to_bytes)
      end
    end

    class PrivateKey < PartyKey 
      attr_reader :rbnacl_key 

      def initialize
        @rbnacl_key = Crypto::SigningKey.generate
      end

      def public_key
        rbnacl_key.verify_key
      end

      def sign(msg)
        DigitalSignature.new(rbnacl_key.sign(msg))
      end
    end

    class PublicKey < PartyKey 
      attr_reader :private_key 
      attr_reader :rbnacl_key 

      def initialize(private_key)
        @private_key = private_key 
        @rbnacl_key = private_key.public_key
      end

      def verify(msg,sig)
        rbnacl_key.verify(msg,sig, :hex) 
      end
    end

  end
end
