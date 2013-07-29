module VaultTree
  module V3
    class MasterPassphrase < Keyword
      attr_reader :contract

      def evaluate
        contract.user_master_passphrase
      end

    end
  end
end
