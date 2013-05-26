module VaultTree
  class Header < ActiveRecord::Base
    belongs_to :contract
  end
end
