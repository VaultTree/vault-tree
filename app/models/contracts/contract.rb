module VaultTree
  class Contract < ActiveRecord::Base

    def self.import(json)
      ContractDeserializer.new().build_contract(json)
    end

  end
end

module VaultTree
  class Contract < ActiveRecord::Base
    has_many :vaults
    has_many :parties

    def as_json
      ContractSerializer.new(presenter).to_json
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
      @json = json
      @contract = Contract.new
      assemble_sections
      saved_contract
    end

    private
    attr_accessor :contract

    def saved_contract
      #@contract.save
    end

    def assemble_sections
      assemble_header
      assemble_parties
      assemble_vaults
      assemble_signature_blocks
    end

    def contract_hash
      @contract_hash ||= ActiveSupport::JSON.decode(json)
    end

    def assemble_header
      puts 'assemble_header'
      puts contract_hash['header']
    end

    def assemble_parties
      puts 'assemble_parties'
      puts contract_hash['parties']
    end

    def assemble_vaults
      puts 'assemble_vaults'
      puts contract_hash['vaults']
    end

    def assemble_signature_blocks
      puts 'assemble_signature_blocks'
      puts contract_hash['signature_blocks']
    end
  end
end
