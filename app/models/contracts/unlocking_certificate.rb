module VaultTree
  class UnlockingCertificate < ActiveRecord::Base
    belongs_to :unlocking_condition

    def active_model_serializer
      UnlockingCertificateSerializer
    end

    def as_json
      active_model_serializer.new(self).to_json
    end
  end
end
