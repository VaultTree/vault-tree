require 'rbnacl'

module LockSmith
  class SymmetricVault < Vault

    def post_initialize
      nil
    end

    def type
      'symmetric_vault'
    end

    def lock
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
