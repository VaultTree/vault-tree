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
