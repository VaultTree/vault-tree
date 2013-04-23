module LockSmith
  class SymmetricVault < Vault

    def type
      'symmetric_vault'
    end

    def lock(key)
      secret_box(key.rbnacl_key)
    end

    private

    def secret_box(rbnacl_key)
      Crypto::SecretBox.new(rbnacl_key) 
    end

    def box_with_nonce
      nonce = Crypto::Random.random_bytes(24)
    end
  end
end
