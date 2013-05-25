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
      contract.save
      contract
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
      contract.checksum = contract_hash['header']['checksum']
      contract.specification = contract_hash['header']['specification']
    end

    def assemble_parties
      contract_hash['parties'].each{|p| contract.parties << Party.new(p)}
    end

    def assemble_vaults
      contract_hash['vaults'].each{|v| contract.vaults << Vault.new(v)}
    end

    def assemble_signature_blocks
      contract_hash['signature_blocks'].each{|sb| contract.signature_blocks << SignatureBlock.new(sb)}
    end
  end
end
