module VaultTree
  class UnlockingCondition < ActiveRecord::Base
    belongs_to :vault
    has_one :unlocking_certificate

    def active_model_serializer
      UnlockingConditionSerializer
    end

    def as_json
      active_model_serializer.new(self).to_json
    end

  end
end
