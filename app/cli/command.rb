module VaultTree
  module CLI
    class Command
      attr_reader :vault_id, :contract_path

      def initialize(opts = {})
        @vault_id = opts[:vault_id]
        @contract_path = opts[:contract_path]
        post_initialize(opts)
      end

      def post_initialize(opts = {})
        nil
      end

      private

      def interpreter
        V3::Interpreter.new
      end

      def user
        V3::User.new(user_id: 'alice', master_passphrase: 'ALICE_SECURE_PASS', shared_contract_secret: 'ALICE_AND_BOB')
      end

      def contract
        V3::Contract.new File.open(expanded_path).read
      end

      def expanded_path
        File.expand_path(contract_path)
      end

    end
  end
end