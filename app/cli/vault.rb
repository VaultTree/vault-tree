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
        c = close_vault
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

      def master_passphrase
        settings.contents[:password]
      end

      def contract
        VaultTree::Contract.new(File.open(contract_path).read, master_passphrase: master_passphrase, external_data: external_data)
      end

      def contract_path
        File.expand_path(settings.active_contract_path)
      end

      def close_vault
        contract.close_vault(vault_id)
      end

      def retrieve_contents
        contract.retrieve_contents(vault_id)
      end
    end
  end
end
