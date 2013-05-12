module VaultTree
  class Vault < ActiveRecord::Base
    belongs_to :contract

    def active_model_serializer
      VaultSerializer
    end

    def as_json
      active_model_serializer.new(self).to_json
    end
  end
end
