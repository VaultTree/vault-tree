module VaultTree
  class VaultList
    attr_reader :vaults_hash, :contract

    def initialize(vaults_hash, contract)
      @vaults_hash = vaults_hash
      @contract = contract
    end

    def close_vault(id)
      begin
        validate_vault(id)
        update_vaults(id, vault(id).close)
        self
      rescue RbNaCl::CryptoError => e
        Notifications::FailedLockAttempt.new(vault_id: id).notify
        raise
      end
    end

    def open_vault(id)
      begin
        validate_vault(id)
        vault(id).open
      rescue RbNaCl::CryptoError => e
        Notifications::FailedUnlockAttempt.new(vault_id: id).notify
        raise
      end
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
      vaults_hash[id]['ciphertext'].nil? || vaults_hash[id]['ciphertext'].empty?
    end

    def update_vaults(id, vault)
      @vaults_hash[id] = vault.properties unless vault.kind_of?(NullVault)
    end

    def vault(id)
      id.nil? ? NullVault.new : Vault.new(id, vaults_hash[id], contract)
    end

    def validate_vault(id)
      unless valid_id?(id)
        Notifications::VaultDoesNotExist.new(vault_id: id).notify
        raise
      end
    end

    def valid_id?(id)
      id.nil? || vaults_hash.include?(id)
    end
  end
end

