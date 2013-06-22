module VaultTree
  module V1
    class ContractModifier
      attr_reader :json

      def initialize(json, opts = {})
        @json = json
        wipe_database_tables
        post_initialize(opts)
      end

      def post_initialize(opts = {})
        nil
      end

      private

      def wipe_database_tables
        # .subclasses defined below
        ActiveRecord::Base.subclasses.each(&:delete_all) 
      end

      def contract
        @contract ||= VaultTree::Contract.import(json)
      end
    end
  end
end

class ActiveRecord::Base
  def self.subclasses
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
