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

    def set_verification_key(vk,pl)
      p = party_with_label(pl)
      p.verification_key = vk
      self.parties << p
    end

    def verification_key(pl)
      party_with_label(pl).verification_key
    end

    def party_with_label(label)
      @party_with_label ||= self.parties.where(label: label).first
    end
  end

  class Contract < ActiveRecord::Base
    def self.import(json)
      ContractDeserializer.new().build_contract(json)
    end
  end

  class NullContract
    attr_reader :msg
    def initialize(msg)
      @msg = msg 
    end
    def as_json
      %Q[{"Error":"#{msg}"}]
    end
  end
end
