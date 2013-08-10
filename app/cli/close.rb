module VaultTree
  module CLI
    class Close < Command 
      attr_reader :write_flag

      def post_initialize(opts = {})
        @write_flag = opts[:write_flag]
      end

      def execute
        c = close_vault
        Status.new(c).present
        save_contract(c) if write_new_contract?
        return 0
      end

      private

      def save_contract(c)
        File.open(expanded_path, 'r+') { |file| file.write(c.as_json) }
      end

      def close_vault
        interpreter.close_vault_path(vault_id: vault_id, contract: contract, user: user)
      end

      def write_new_contract?
        @write_flag
      end

    end
  end
end

# Use this command
# bundle exec bin/vault-tree close '~/projects/vault-tree/vault-tree/spec/support/fixtures/one_two_three-0.3.0.EXP.json' 'alice_public_encryption_key'
