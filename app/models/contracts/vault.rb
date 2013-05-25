module VaultTree
  class Vault < ActiveRecord::Base
    belongs_to :contract
    belongs_to :custodian, class_name: "VaultTree::Party"
  end
end
