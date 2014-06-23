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
      LockSmith.new(
        public_key: vault_key.public,
        private_key: vault_key.secret,
        message: message
      ).asymmetric_encrypt
    end

    def symmetric_ciphertext
      LockSmith.new(
        message: message,
        secret_key: vault_key.secret
      ).symmetric_encrypt
    end
  end
end
