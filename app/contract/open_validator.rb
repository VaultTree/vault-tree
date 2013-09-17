module VaultTree
  class OpenValidator
    attr_reader :vault

    def initialize(vault)
      @vault = vault
    end

    def validate!
      confirm_vault_not_empty
      true
    end

    private

    def confirm_vault_not_empty
      raise Exceptions::EmptyVault if vault.empty?
    end
  end
end
