module VaultTree
  module Expressions
    class ExternalInput
      def initialize(a)
        @id = a
      end
      attr_reader :id

      def evaluate(c, vault_id)
        raise MissingExternalInputError if missing_external_input?(id, c)
        c['external_input'][id]
      end

      def missing_external_input?(id, c)
        c['external_input'].nil? || c['external_input'][id].nil?
      end
    end
  end
end

class MissingExternalInputError < StandardError
end
