module VaultTree
  class Contract
    attr_reader :json

    def initialize(json, params = {})
      @json = json
      @external_data = params[:external_data]
    end

    def close_vault(id, params = {data: nil})
      update_external_data(id: id , data: params[:data])
      validate_vault(id)
      update_vaults vault(id).close
      self
    end

    def retrieve_contents(id)
      validate_vault(id)
      vault(id).retrieve_contents
    end

    def vault_closed?(id)
      non_empty_contents?(id)
    end

    def header
      contract["header"]
    end

    def vaults
      contract["vaults"]
    end

    def vault(id)
      id.nil? ? NullVault.new : Vault.new(id, vaults[id], self)
    end

    def update_vaults(vault)
      @contract["vaults"][vault.id] = vault.properties unless vault.kind_of?(NullVault)
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

    def valid_id?(id)
      id.nil? || vaults.include?(id)
    end

    def non_empty_contents?(id)
      ! empty_contents?(id)
    end

    def empty_contents?(id)
      vaults[id]['contents'].nil? || vaults[id]['contents'].empty?
    end

    def contract
      @contract ||= Support::JSON.decode(json)
    end

    def validate_vault(id)
      raise Exceptions::VaultDoesNotExist unless valid_id?(id)
    end

    def update_external_data(params)
      vault_id = params[:id]
      data = params[:data]
      @external_data = @external_data.merge({"#{vault_id}" => "#{data}"}) unless data.nil?
    end
  end
end
