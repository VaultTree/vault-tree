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

    def open_vault(id)
      validate_vault(id)
      vault(id).open_vault
    end

    def vault_closed?(id)
      non_empty_contents?(id)
    end

    def to_hash
      @vaults_hash
    end

    private

    def non_empty_contents?(id)
      ! empty_contents?(id)
    end

    def empty_contents?(id)
      vaults_hash[id]['contents'].nil? || vaults_hash[id]['contents'].empty?
    end

    def update_vaults(vault)
      @vaults_hash[vault.id] = vault.properties unless vault.kind_of?(NullVault)
    end

    def vault(id)
      id.nil? ? NullVault.new : Vault.new(id, vaults_hash[id], contract)
    end

    def validate_vault(id)
      raise Exceptions::VaultDoesNotExist.new(nil,vault_id: id) unless valid_id?(id)
    end

    def valid_id?(id)
      id.nil? || vaults_hash.include?(id)
    end
  end
end

