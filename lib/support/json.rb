module VaultTree
  module Support
    module JSON
      extend self

      def encode(ruby_hash)
        ActiveSupport::JSON.encode(ruby_hash)
      end

      def decode(json)
        ActiveSupport::JSON.decode(json)
      end
    end
  end
end
