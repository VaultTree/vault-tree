module VaultTree
  class Contract < ActiveRecord::Base
    has_one :genesis_vault
    has_one :contract_header
    has_many :vaults

    def active_model_serializer
      ContractSerializer
    end

    def as_json
      self.donkey = 'grey'
      self.zebra = 'black and white'
      self.save
      active_model_serializer.new(self).to_json
    end
  end
end
