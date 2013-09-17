module VaultTree
  class MasterPassphrase < Keyword

    def evaluate
      contract.user_master_passphrase
    end

  end
end
