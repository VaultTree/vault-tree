module VaultTree
  class Contract < ActiveRecord::Base
    has_one :header
    has_many :vaults
    has_many :parties
    has_many :signature_blocks

    def active_model_serializer
      ContractSerializer
    end

    def as_json
      active_model_serializer.new(self).to_json
    end
  end

  class Contract < ActiveRecord::Base

    def self.import(json)
      ContractDeserializer.new().build_contract(json)
    end
  end
end

module VaultTree
  class ContractSerializer < ActiveModel::Serializer
    has_one :header
    has_many :parties
    has_many :vaults
    has_many :signature_blocks
  end
end

module VaultTree
  class ContractPresenter < ActiveModel::Serializer
  end
end
