module VaultTree
  class Vault
    attr_reader :id, :properties, :contract

    def initialize(id, properties, contract)
      @id = id
      @properties = properties
      @contract = contract
    end

    def close
      @properties['ciphertext'] = locked_contents
      self
    end

    def open
      self.close
      unlocked_contents
    end

    def filler
      interpret_keyword('contents')
    end

    def locking_key
      VaultKey.new interpret_keyword('lock_key')
    end

    def unlocking_key
      VaultKey.new interpret_keyword('unlock_with')
    end

    def locked_contents
      already_locked? ? properties['ciphertext'] : ciphertext(filler)
    end

    def unlocked_contents
      plaintext properties['ciphertext']
    end

    def ciphertext(m)
      ContentCiphertext.new(m, locking_key).evaluate
    end

    def plaintext(c)
      ContentPlaintext.new(c, unlocking_key).evaluate
    end

    def already_locked?
      ! (properties['ciphertext'].nil? || properties['ciphertext'].empty?)
    end

    def interpret_keyword(prop_key)
      KeywordInterpreter.new(properties[prop_key], self).evaluate
    end

  end
end
