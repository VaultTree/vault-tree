module VaultTree
  class Contract
    attr_reader :json, :vault_list

    def initialize(json, params = {})
      @json = json
      @external_data = params[:external_data]
      @vault_list = VaultList.new(contract_hash["vaults"], self)
    end

    def close_vault(id, params = {data: nil})
      update_external_data(id: id , data: params[:data])
      @vault_list = vault_list.close_vault(id)
      self
    end

    def retrieve_contents(id)
      vault_list.retrieve_contents(id)
    end

    def vault_closed?(id)
      vault_list.vault_closed?(id)
    end

    def header
      contract_hash["header"]
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

    def contract_hash
      @contract_hash ||= Support::JSON.decode(json)
    end

    def update_external_data(params)
      vault_id = params[:id]
      data = params[:data]
      @external_data = @external_data.merge({"#{vault_id}" => "#{data}"}) unless data.nil?
    end
  end
end
