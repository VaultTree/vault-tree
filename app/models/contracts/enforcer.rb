module VaultTree
  class Enforcer < ActiveRecord::Base
    belongs_to :contract
    has_many :symmetric_vaults
    has_many :asymmetric_vaults
  end
end
