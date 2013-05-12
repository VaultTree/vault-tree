module VaultTree
  class ContractHeader < ActiveRecord::Base
    belongs_to :contract
  end
end
