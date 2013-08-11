module VaultTree
  module V3
    class MasterPassphrase < Keyword

      def evaluate
        contract.user_master_passphrase
      end

    end
  end
end
