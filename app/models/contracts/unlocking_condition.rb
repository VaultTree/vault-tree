module VaultTree
  class UnlockingCondition < ActiveRecord::Base
    belongs_to :vault
    has_one :unlocking_certificate
  end
end
