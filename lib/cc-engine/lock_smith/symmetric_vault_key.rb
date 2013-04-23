module LockSmith
  class SymmetricVaultKey
    attr_reader :rbnacl_key   

    def initialize(opts = {})
      @rbnacl_key = opts[:rbnacl_key] || generate_key
    end

    private

    def generate_key
      Crypto::Random.random_bytes(Crypto::SecretBox::KEYBYTES) 
    end
  end
end
