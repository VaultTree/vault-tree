module VaultTree
  class MasterPassphrase < Keyword

    def evaluate
      contract.master_passphrase
    end

  end
end
