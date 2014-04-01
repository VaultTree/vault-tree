module VaultTree
  class VaultList
    attr_reader :vaults_hash, :contract

    def initialize(vaults_hash, contract)
      @vaults_hash = vaults_hash
      @contract = contract
    end

    def close_vault(id)
      validate_vault(id)
      update_vaults vault(id).close
      self
    end

    def retrieve_contents(id)
      validate_vault(id)
    end

    def to_hash
      @vaults_hash
    end

    private

    def update_vaults(vault)
      @vaults_hash[vault.id] = vault.properties unless vault.kind_of?(NullVault)
    end

    def vault(id)
      id.nil? ? NullVault.new : Vault.new(id, vaults_hash[id], contract)
    end

    def validate_vault(id)
      raise Exceptions::VaultDoesNotExist unless valid_id?(id)
    end

    def valid_id?(id)
      id.nil? || vaults_hash.include?(id)
    end
  end
end

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
      @vault_list = @vault_list.close_vault(id)
      self
    end

    def retrieve_contents(id)
      vault_list.retrieve_contents(id)
      vault(id).retrieve_contents
    end

    def vault_closed?(id)
      non_empty_contents?(id)
    end

    def header
      contract_hash["header"]
    end

    def vaults
      vault_list.to_hash
    end

    def vault(id)
      id.nil? ? NullVault.new : Vault.new(id, vaults[id], self)
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
