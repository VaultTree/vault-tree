module VaultTree
  class Party < ActiveRecord::Base
    belongs_to :contract
  end
end
