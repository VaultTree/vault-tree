module VaultTree
  class Contract
    attr_reader :json, :contract_hash, :vault_list, :contract_header, :external_input

    def initialize(json, params = {})
      @contract_hash   = decode_json(json)
      @contract_header = ContractHeader.new(contract_hash["header"])
      @vault_list      = VaultList.new(contract_hash["vaults"], self)
      @external_input = {}
    end

    def close_vault(id, external_input = {data: nil})
      @external_input = @external_input.merge(external_input)
      @vault_list = vault_list.close_vault(id)
      self.as_json
    end

    def open_vault(id, external_input = {})
      @external_input = @external_input.merge(external_input)
      vault_list.open_vault(id)
    end

    def vault_closed?(id)
      vault_list.vault_closed?(id)
    end

    def header
      contract_header.to_hash
    end

    def vaults
      vault_list.to_hash
    end

    def decode_json(json)
      validate_json json
      Support::JSON.decode json
    end

    def validate_json(j)
      #JSON::Validator.validate('schemas/schema.json', single_vault, :validate_schema => true )
      return j
    end

    def as_json
      ContractPresenter.new(self).as_json
    end
  end
end
