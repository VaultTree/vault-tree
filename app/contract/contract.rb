module VaultTree
  class Contract
    attr_accessor :user
    attr_reader :json

    def initialize(json, params = {})
      @json = json
      @contract = Support::JSON.decode(json)
      @master_passphrase = params[:master_passphrase]
      @external_data = params[:external_data]
      @user = nil
    end

    def vault_closed?(vault_id)
      non_empty_contents?(vault_id)
    end

    def vaults
      contract["vaults"]
    end

    def close_vault_path(vault_id) 
      Vault.new(vault_id, self).close_path
    end

    def retrieve_vault_contents(vault_id) 
      confirm_vault_exists(vault_id)
      Vault.new(vault_id, self).retrieve_contents
    end

    def set_vault_contents(vault_id, encrypted_content)
      vaults[vault_id]['contents'] = encrypted_content 
      self
    end

    def as_json
      ContractPresenter.new(self).as_json
    end

    def user_master_passphrase
      user.master_passphrase
    end

    def user_public_encryption_key
      user.public_encryption_key
    end

    def user_decryption_key 
      user.decryption_key 
    end

    def user_external_data(vault_id)
      user.external_data[vault_id]
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

    def confirm_vault_exists(vault_id)
      if ! vaults.include?(vault_id)
        raise Exceptions::VaultDoesNotExist
      end
    end

    def non_empty_contents?(vault_id)
      vaults[vault_id]['contents'].non_empty?
    end

  end
end
