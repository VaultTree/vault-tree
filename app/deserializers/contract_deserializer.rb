module VaultTree
  class ContractDeserializer
    attr_reader :json

    def build_contract(json)
      @json = json
      @contract = Contract.new
      assemble_and_save_contract
    end

    private
    attr_accessor :contract

    def assemble_and_save_contract
      begin
        assemble_sections
        saved_contract
      rescue(MultiJson::DecodeError)
        NullContract.new('Malformed JSON')
      end
    end

    def saved_contract
      contract.save!
      contract
    end

    def assemble_sections
      assemble_header
      assemble_parties
      assemble_vaults
      assemble_signature_blocks
    end

    def contract_hash
      @contract_hash ||= Support::JSON.decode(json)
    end

    def assemble_header
     contract.header = Header.new(contract_hash['header'])
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
