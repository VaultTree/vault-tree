module VaultTree
  class Vault
    attr_reader :id, :properties, :contract

    def initialize(id, properties, contract)
      @id = id
      @properties = properties
      @contract = contract
    end

    def close
      @properties['contents'] = doorman.lock_contents
      self
    end

    def open
      contract.close_vault(id)
      doorman.unlock_contents
    end

    def doorman
      @doorman ||= Doorman.new(
        vault: self,
        id: id,
        properties: properties
      )
    end

    def fill_with
      properties['fill_with']
    end

    def lock_with
      properties['lock_with']
    end

    def unlock_with
      properties['unlock_with']
    end

    def contents
      properties['contents']
    end

    def filler
      KeywordInterpreter.new(fill_with, self).evaluate
    end

    def locking_key
      KeywordInterpreter.new(lock_with, self).evaluate
    end

    def unlocking_key
      KeywordInterpreter.new(unlock_with, self).evaluate
    end

  end
end
