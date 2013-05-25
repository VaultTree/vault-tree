module VaultTree
  class Vault < ActiveRecord::Base
    belongs_to :contract
    belongs_to :party # as a custodian 
  end
end
