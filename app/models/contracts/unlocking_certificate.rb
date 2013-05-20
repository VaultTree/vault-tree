module VaultTree
  class UnlockingCertificate < ActiveRecord::Base
    belongs_to :unlocking_condition
  end
end
