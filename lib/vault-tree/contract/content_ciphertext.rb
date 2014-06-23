module VaultTree
  class ContentCiphertext
    attr_reader :message, :vault_key

    def initialize(c,k)
      @message = c
      @vault_key = k
    end

    def evaluate
      vault_key.asymmetric? ? asymmetric_ciphertext : symmetric_ciphertext
    end

    private

    def asymmetric_ciphertext
      lock_smith.asymmetric_encrypt
    end

    def symmetric_ciphertext
      lock_smith.symmetric_encrypt
    end

    def lock_smith
      LockSmith.new(
        public_key: vault_key.public,
        private_key: vault_key.secret,
        secret_key: vault_key.secret,
        message: message
      )
    end
  end
end
