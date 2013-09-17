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
        User.new(master_passphrase: master_passphrase, external_data: external_data)
      end

      def master_passphrase
        settings.contents[:password]
      end

      def contract
        # Here we want app/contract.rb not app/cli/contract.rb
        VaultTree::Contract.new File.open(contract_path).read
      end

      def contract_path
        File.expand_path(settings.active_contract_path)
      end

      def interpreter
        VaultTree::Interpreter.new
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
