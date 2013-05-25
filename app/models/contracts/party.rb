module VaultTree
  class Party < ActiveRecord::Base
    has_many :vaults
    belongs_to :contract
  end
end
