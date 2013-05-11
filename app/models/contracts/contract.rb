module VaultTree
  class Contract < ActiveRecord::Base
    has_one :contract_header
    has_many :symmetric_vaults
    has_many :asymmetric_vaults
    has_one :genesis_vault
  end
end
