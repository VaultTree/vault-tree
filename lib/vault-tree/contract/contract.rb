module VaultTree
  class Contract
    attr_reader :json, :contract_hash, :vault_list, :contract_header, :external_input

    def initialize(json, params = {})
      @contract_hash   = Support::JSON.decode(json)
      @contract_header = ContractHeader.new(contract_hash["header"])
      @vault_list      = VaultList.new(contract_hash["vaults"], self)
      @external_data   = params[:external_data] # Replace With ExternalContractData Class
      @external_input = {}
    end

    def close_vault(id, external_input = {data: nil})
      if external_input.has_key?(:data)
        update_external_data(id: id , data: external_input[:data])
        @vault_list = vault_list.close_vault(id)
        self
      else
        @external_input = @external_input.merge(external_input)
        @vault_list = vault_list.close_vault(id)
        self
      end
    end

    def retrieve_contents(id, external_input = {})
      @external_input = @external_input.merge(external_input)
      vault_list.retrieve_contents(id)
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

    def as_json
      ContractPresenter.new(self).as_json
    end

    def external_data_hash
      @external_data
    end

    def external_data(id)
      @external_data[id]
    end

    private

    def update_external_data(params)
      vault_id = params[:id]
      data = params[:data]
      @external_data = @external_data.merge({"#{vault_id}" => "#{data}"}) unless data.nil?
    end
  end
end
