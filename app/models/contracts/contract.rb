module VaultTree
  class Contract < ActiveRecord::Base
    has_many :vaults
    has_many :parties

    def as_json
      ContractSerializer.new(presenter).to_json
    end

    def self.import(json)
      ContractDeserializer.new().build_contract(json)
    end

    private

    def presenter
      ContractPresenter.new(self)
    end
  end
end

module VaultTree
  class ContractDeserializer
    attr_reader :json

    def build_contract(json)
      assemble_vaults
      assemble_parties
      assemble_signatures
      assemble_header
    end

    private

    def contract_hash
      @contract_hash ||= ActiveSupport::JSON.decode(json)
    end

    def assemble_vaults
      puts 'assemble_vaults'
    end

    def assemble_parties
      puts 'assemble_parties'
    end

    def assemble_signatures
      puts 'assemble_signatures'
    end

    def assemble_header
      puts 'assemble_header'
    end

  end
end
