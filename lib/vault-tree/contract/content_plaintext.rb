module VaultTree
  class ContentPlaintext
    attr_reader :content_string, :vault_key

    def initialize(c,k)
      @content_string = c
      @vault_key = k
    end

    def evaulate
      vault_key.asymmetric? ? asymmetric_plaintext : symmetric_plaintext
    end

    private

    def asymmetric_plaintext
      LockSmith.new(
        public_key: vault_key.public,
        private_key: vault_key.secret,
        cipher_text: content_string
      ).asymmetric_decrypt
    end

    def symmetric_plaintext
      LockSmith.new(
        cipher_text: content_string,
        secret_key: vault_key.secret
      ).symmetric_decrypt
    end
  end
end
