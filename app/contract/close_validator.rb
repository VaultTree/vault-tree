module VaultTree
  class CloseValidator
    attr_reader :vault

    def initialize(vault)
      @vault = vault
    end

    def validate!
      confirm_valid_fill_keyword
      validate_external_data
      true
    end

    private

    def confirm_valid_fill_keyword
      raise Exceptions::FillAttemptMasterPassword if vault.fill_with == 'MASTER_PASSPHRASE'
    end

    def validate_external_data
      if external_data_required? && external_data_missing?
        raise Exceptions::MissingExternalData
      end
    end

    def external_data_required?
      vault.fill_with == 'EXTERNAL_DATA'
    end

    def external_data_missing?
      vault.contract.user_external_data(vault.vault_id).nil?
    end
  end
end
