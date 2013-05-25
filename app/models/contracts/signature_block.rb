module VaultTree
  class SignatureBlock < ActiveRecord::Base
    belongs_to :contract
  end
end
