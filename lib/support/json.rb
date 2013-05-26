module VaultTree
  module Support
    module JSON
      extend self

      def encode(json)
        ActiveSupport::JSON.encode(json)
      end

      def decode(ruby_hash)
        ActiveSupport::JSON.decode(ruby_hash)
      end
    end
  end
end
