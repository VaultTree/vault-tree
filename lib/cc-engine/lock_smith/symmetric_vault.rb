require 'rbnacl'

module LockSmith
  class SymmetricVault < Vault

    def post_initialize
      nil
    end

    def domain_class
      'symmetric_vault'
    end

    def lock
      @key = Crypto::Random.random_bytes(Crypto::SecretBox.key_bytes)
      @box = Crypto::RandomNonceBox.from_secret_key(@key)
      @string = @box.box(self.as_json, encoding = :base32)
    end

    def unlock
      @box = Crypto::RandomNonceBox.from_secret_key(@key)
      @string = @box.open(self.as_json, encoding = :base32)
    end

    def lock_down(key)
      validate_key(key)
      bytes = key.rbnacl_key_bytes
      box = Crypto::RandomNonceBox.from_secret_key(bytes)
      @string = box.box(self.as_json, encoding = :base32)
    end

    def open_up(key)
      validate_key(key)
      begin
        bytes = key.rbnacl_key_bytes
        box = Crypto::RandomNonceBox.from_secret_key(bytes)
        @string = box.open(self.as_json, encoding = :base32)
      rescue
        return nil
      end
    end

    private

    def validate_key(key)
      unless key.respond_to?(:rbnacl_key_bytes)
        raise 'expect and argument that responds to :rbnacl_key_bytes'
      end
    end

  end
end
