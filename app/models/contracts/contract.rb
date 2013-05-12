module VaultTree
  class Contract < ActiveRecord::Base
    has_one :contract_header
    has_many :vaults

    def active_model_serializer
      ContractSerializer
    end

    def as_json
      active_model_serializer.new(self).to_json
    end
  end
end
