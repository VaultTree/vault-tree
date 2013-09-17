module VaultTree
  class AsymmetricVaultOpener
    attr_reader :vault

    def initialize(vault)
      @vault = vault
    end

    def open
      asymmetric_cipher.decrypt(vault.asym_verify_key, vault.unlocking_key, vault.contents)
    end

    private

    def asymmetric_cipher
      LockSmith::AsymmetricCipher.new
    end

  end
end
