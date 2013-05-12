module VaultTree
  class Vault < ActiveRecord::Base
    belongs_to :contract
  end
end
