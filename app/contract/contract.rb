module VaultTree
  class Contract
    attr_reader :json
    attr_accessor :external_data

    def initialize(json, params = {})
      @json = json
      @contract = decode_json
      @master_passphrase = params[:master_passphrase]
      @external_data = params[:external_data]
    end

    def vault_closed?(id)
      non_empty_contents?(id)
    end

    def vaults
      contract["vaults"]
    end

    def vault(id)
      id.nil? ? NullVault.new : Vault.new(id, vaults[id], self)
    end

    def close_vault(id) 
      update_vaults vault(id).close
      self
    end

    def update_vaults(vault)
      @contract["vaults"][vault.id] = vault.properties unless vault.kind_of?(NullVault)
    end

    def retrieve_contents(id) 
      validate_vault(id)
      vault(id).retrieve_contents
    end

    def as_json
      ContractPresenter.new(self).as_json
    end

    def user_master_passphrase
      master_passphrase
    end

    def user_external_data(id)
      external_data[id]
    end

    private
    attr_accessor :contract

    def master_passphrase
      raise Exceptions::MissingPassphrase if passphrase_missing?
      @master_passphrase
    end

    def passphrase_missing?
      @master_passphrase.nil?
    end

    def validate_vault(id)
      if ! vaults.include?(id)
        raise Exceptions::VaultDoesNotExist
      end
    end

    def non_empty_contents?(id)
      ! empty_contents?(id)
    end

    def empty_contents?(id)
      vaults[id]['contents'].nil? || vaults[id]['contents'].empty?
    end

    def decode_json
      Support::JSON.decode(json)
    end
  end
end
