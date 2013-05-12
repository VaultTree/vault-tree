module VaultTree
  class SymmetricVault < ActiveRecord::Base
    belongs_to :enforcer
  end
end
