module VaultTree
  class SymmetricVaultCloser
    attr_reader :vault

    def initialize(vault)
      @vault = vault
    end

    def close
      symmetric_cipher.encrypt(key: vault.locking_key, plain_text: vault.filler)
    end

    private

    def symmetric_cipher
      LockSmith::SymmetricCipher.new
    end
  end
end
