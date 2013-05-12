module VaultTree
  class Contract < ActiveRecord::Base
    has_one :genesis_vault
    has_one :contract_header
    has_many :vaults
  end
end
