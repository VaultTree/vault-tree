module VaultTree
  module CLI
    class Command
      attr_reader :vault_id, :contract_path, :master_password

      def initialize(opts = {})
        @master_password = opts[:master_password]
        @vault_id = opts[:vault_id]
        @contract_path = opts[:contract_path]
        post_initialize(opts)
      end

      def post_initialize(opts = {})
        nil
      end

      private

      def interpreter
        Interpreter.new
      end

      def contract
        Contract.new File.open(expanded_path).read
      end

      def expanded_path
        File.expand_path(contract_path)
      end

    end
  end
end
