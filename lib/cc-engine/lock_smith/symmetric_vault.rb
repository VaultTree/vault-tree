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
      @key = Crypto::Random.random_bytes(Crypto::SecretBox.key_bytes)
      @box = Crypto::RandomNonceBox.from_secret_key(@key)
      @string = @box.box(self.as_json, encoding = :base32)
      return true
    end

    def unlock
      @box = Crypto::RandomNonceBox.from_secret_key(@key)
      @string = @box.open(self.as_json, encoding = :base32)
      return true
    end
  end
end
