module VaultTree
  module CLI
    class Status
      attr_reader :contract

      def initialize(contract)
        @contract = contract
      end

      def present
        print_status_header
        print_vault_status
      end

      private

      def print_status_header
        STDOUT.write "CONTRACT STATUS \n"
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

    end
  end
end

class String
  def name_from_id
    self.upcase.gsub('_',' ')
  end
end
