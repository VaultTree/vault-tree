module VaultTree
  class Vault < ActiveRecord::Base
    belongs_to :contract
    belongs_to :party
    scope :with_label, lambda { |label| where(:label => label) }

    def fill(c)
      self.content = c
      save!
    end

    def lock(key)
      self.content = symmetric_cipher.encrypt(plain_text: content, key: key)
      save!
    end

    def unlock(key)
      self.content = symmetric_cipher.decrypt(cipher_text: content, key: key)
      save!
    end

    def sign(signing_key)
      self.signed_vault_content = content_signature(signing_key)
      save!
    end

    private

    def content_signature(key)
      LockSmith::DigitalSignature.new(signing_key: key, message: self.content).generate
    end

    def symmetric_cipher
      @symmetric_cipher ||= LockSmith::SymmetricCipher.new
    end

  end
end
