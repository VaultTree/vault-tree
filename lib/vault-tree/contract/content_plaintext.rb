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
      LockSmith.new(
        public_key: vault_key.public,
        private_key: vault_key.secret,
        cipher_text: cipher_text
      ).asymmetric_decrypt
    end

    def symmetric_plaintext
      LockSmith.new(
        cipher_text: cipher_text,
        secret_key: vault_key.secret
      ).symmetric_decrypt
    end
  end
end
