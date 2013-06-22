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

    private

    def symmetric_cipher
      @symmetric_cipher ||= LockSmith::SymmetricCipher.new
    end

  end
end
