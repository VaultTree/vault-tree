module VaultTree
  module CLI
    class Vault

      def open
      end

      def close
      end

    end
  end
end

module VaultTree
  module CLI
    class Open < Command

      def execute
        puts retrieve_contents
        return 0
      end

      private

      def user
        V3::User.new(master_passphrase: master_passphrase)
      end

      def retrieve_contents
        interpreter.retrieve_contents(vault_id: vault_id, contract: contract, user: user)
      end
    end
  end
end


module VaultTree
  module CLI
    class Close < Command 
      attr_reader :write_flag, :external_data

      def post_initialize(opts = {})
        @write_flag = opts[:write_flag]
        @external_data = opts[:external_data]
      end

      def execute
        c = close_vault
        Status.new(c).present
        save_contract(c) if write_new_contract?
        return 0
      end

      private

      def user
        V3::User.new(master_passphrase: master_passphrase, external_data: external_data)
      end

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
# bundle exec bin/vault-tree -p 'ALICE_SECURE_PASS' close '~/projects/vault-tree/vault-tree/spec/support/fixtures/one_two_three-0.3.0.EXP.json' 'alice_public_encryption_key'

