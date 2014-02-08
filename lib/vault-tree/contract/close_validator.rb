module VaultTree
  class CloseValidator
    attr_reader :vault

    def initialize(vault)
      @vault = vault
    end

    def validate!
      confirm_valid_fill_keyword
      true
    end

    private

    def confirm_valid_fill_keyword
      true
    end

    def external_data_required?
      vault.fill_with == 'EXTERNAL_DATA'
    end

    def external_data_missing?
      vault.contract.external_data(vault.id).nil?
    end
  end
end
