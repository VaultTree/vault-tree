module VaultTree
  class GenesisVault < ActiveRecord::Base
    belongs_to :contract
  end
end
