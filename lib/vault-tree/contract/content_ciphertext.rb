module VaultTree
  class ContentCiphertext
    attr_reader :content_string, :vault_key

    def initialize(c,k)
      @content_string = c
      @vault_key = k
    end

    def evaulate
      vault_key.asymmetric? ? asymmetric_ciphertext : symmetric_ciphertext
    end

    private

    def asymmetric_ciphertext
      LockSmith.new(
        public_key: vault_key.public,
        private_key: vault_key.secret,
        message: filler
      ).asymmetric_encrypt
    end

    def symmetric_ciphertext
      LockSmith.new(
        message: content_string,
        secret_key: vault_key.secret
      ).symmetric_encrypt
    end
  end
end
