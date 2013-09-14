module VaultTree
  module CLI
    class Vault
      attr_reader :settings, :external_data, :vault_id, :options

      def initialize(settings, options)
        @settings = settings
        @options = options
      end

      def open(vault_id,arg2 = nil)
        @vault_id = vault_id
        STDOUT.write retrieve_contents
        return 0
      end

      def close(vault_id, data_file_name = nil)
        @vault_id = vault_id 
        @external_data = external_data_hash(data_file_name)
        c = close_vault_path
        Status.new(settings).run(c)
        if write_to_disk?
          write_conract(c)
        end
        return 0
      end

      def write_to_disk?
        options[:write]
      end

      private

      def write_conract(c)
        File.open(contract_path, 'w') { |file| file.write(c.as_json) }
      end

      def external_data_hash(data_file_name)
        data_path = settings.contents[:data][data_file_name]
        Support::JSON.decode File.read(data_path)
      end

      def user
        V3::User.new(master_passphrase: master_passphrase, external_data: external_data)
      end

      def master_passphrase
        settings.contents[:password]
      end

      def contract
        V3::Contract.new File.open(contract_path).read
      end

      def contract_path
        File.expand_path(settings.active_contract_path)
      end

      def interpreter
        V3::Interpreter.new
      end

      def close_vault_path
        interpreter.close_vault_path(vault_id: vault_id, contract: contract, user: user)
      end

      def retrieve_contents
        interpreter.retrieve_contents(vault_id: vault_id, contract: contract, user: user)
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

