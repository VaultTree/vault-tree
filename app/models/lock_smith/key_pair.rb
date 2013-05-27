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


    class String
      def base32_encoded?
      end
    end

    class PartyKey
    end

    class PrivateKey < PartyKey 
      attr_reader :rbnacl_key 

      def initialize
        @rbnacl_key = Crypto::PrivateKey.generate
      end

      def to_s
        HexEncoder.new.encode(rbnacl_key.to_bytes)
      end
    end

    class PublicKey < PartyKey 
      attr_reader :private_key 
      attr_reader :rbnacl_key 

      def initialize(private_key)
        @private_key = private_key 
        @rbnacl_key = private_key.rbnacl_key.public_key
      end

      def to_s
        HexEncoder.new.encode(rbnacl_key.to_bytes)
      end
    end
  end
end
