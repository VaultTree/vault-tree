module VaultTree
  class Node < ActiveRecord::Base
    belongs_to :contract
    has_one :vault
  end
end
