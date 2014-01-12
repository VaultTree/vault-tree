require 'json'

module VaultTree
  module Support
    module JSON
      extend self

      def encode(ruby_hash)
        ::JSON.generate(ruby_hash)
      end

      def decode(json)
        ::JSON.parse(json)
      end
    end
  end
end
