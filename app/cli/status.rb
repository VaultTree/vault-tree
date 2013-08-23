module VaultTree
  module CLI
    class Status
      attr_reader :settings

      def initialize(settings)
        @settings = settings
      end

      def run(contract = nil)
        @contract = contract  
        present
        return 0
      end

      private

      def present
        print_status_header
        print_vault_status
      end

      def print_status_header
        STDOUT.write "Contract Status \n"
      end

      def print_vault_status
        i = 1
        vault_ids.each do |id| 
          printf "%-5s %-20s %s\n", "[#{i}]", lock_status(id), id.name_from_id
          i = i + 1
        end
      end

      def lock_status(id)
        if contract.vault_closed?(id)
          'CLOSED'.color(:green)
        else
          'EMPTY'.color(:yellow)
        end
      end

      def vault_ids
        contract.vaults.keys
      end

      private

      def interpreter
        V3::Interpreter.new
      end

      def contract
        @contract || V3::Contract.new(contract_contents) 
      end

      def contract_contents
        File.open(contract_path).read
      end

      def contract_path
        File.expand_path(settings.active_contract_path)
      end

    end
  end
end

class String
  def name_from_id
    self.upcase.gsub('_',' ')
  end
end
