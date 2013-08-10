module VaultTree
  module CLI
    class Close 
      attr_reader :vault_id, :contract_path, :write_flag

      def initialize(opts = {})
        @vault_id = opts[:vault_id]
        @contract_path = opts[:contract_path]
        @write_flag = opts[:write_flag]
      end

      def execute
        Status.new(close_vault).present
      end

      private

      def close_vault
        interpreter.close_vault_path(vault_id: vault_id, contract: contract, user: user)
      end

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

      def write_new_contract?
        @write_flag
      end

    end
  end
end

# Use this command
# bundle exec bin/vault-tree close '~/projects/vault-tree/vault-tree/spec/support/fixtures/one_two_three-0.3.0.EXP.json' 'alice_public_encryption_key'
