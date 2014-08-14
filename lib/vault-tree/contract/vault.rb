module VaultTree
  class Vault
    attr_reader :id, :properties, :contract

    def initialize(id, properties, contract)
      @id = id
      @properties = properties
      @contract = contract
    end

    def close
      @properties['contents'] = locked_contents
      self
    end

    def open
      self.close
      unlocked_contents
    end

    def filler
      KeywordInterpreter.new(properties['fill_with'], self).evaluate
    end

    def locking_key
      VaultKey.new KeywordInterpreter.new(properties['lock_with'], self).evaluate
    end

    def unlocking_key
      VaultKey.new KeywordInterpreter.new(properties['unlock_with'], self).evaluate
    end

    def locked_contents
      already_locked? ? properties['contents'] : ciphertext(filler)
    end

    def unlocked_contents
      plaintext properties['contents']
    end

    def ciphertext(m)
      ContentCiphertext.new(m, locking_key).evaluate
    end

    def plaintext(c)
      ContentPlaintext.new(c, unlocking_key).evaluate
    end

    def already_locked?
      ! (properties['contents'].nil? || properties['contents'].empty?)
    end

  end
end
