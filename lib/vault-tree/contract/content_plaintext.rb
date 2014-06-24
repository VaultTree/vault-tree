module VaultTree
  class ContentPlaintext
    attr_reader :cipher_text, :vault_key

    def initialize(c,k)
      @cipher_text = c
      @vault_key = k
    end

    def evaluate
      vault_key.asymmetric? ? asymmetric_plaintext : symmetric_plaintext
    end

    private

    def asymmetric_plaintext
      lock_smith.asymmetric_decrypt
    end

    def symmetric_plaintext
      lock_smith.symmetric_decrypt
    end

    def lock_smith
      LockSmith.new(
        public_key: vault_key.public,
        private_key: vault_key.secret,
        secret_key: vault_key.secret,
        cipher_text: cipher_text
      )
    end
  end
end
