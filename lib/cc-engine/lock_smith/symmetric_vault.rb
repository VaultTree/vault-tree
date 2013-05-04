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
      key = Crypto::Random.random_bytes(Crypto::SecretBox.key_bytes)
      crypto_secret_box = Crypto::SecretBox.new(key)
      nonce = Crypto::Random.random_bytes(crypto_secret_box.nonce_bytes)
      message = self.as_json
      @string = HexEncoder.new.encode(crypto_secret_box.box(nonce, message)) 
    end
  end
end
