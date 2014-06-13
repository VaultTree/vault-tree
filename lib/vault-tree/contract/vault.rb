module VaultTree
  class Vault
    attr_reader :id, :properties, :contract

    def initialize(id, properties, contract)
      @id = id
      @properties = properties
      @contract = contract
    end

    def close
      close_ancestors
      close_self
    end

    def open
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
      doorman.fill_with
    end

    def lock_with
      doorman.lock_with
    end

    def unlock_with
      doorman.unlock_with
    end

    def contents
      doorman.contents
    end

    def empty?
      doorman.empty_contents?
    end

    def closed?
      ! empty?
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

    private

    def close_ancestors
      close_lock_ancestor
      close_fill_ancestor
    end

    def close_self
      @properties['contents'] = locked_contents
      self
    end

    def locked_contents
      doorman.lock_contents
    end

    def close_lock_ancestor
      contract.close_vault(lock_ancestor_id)
    end

    def close_fill_ancestor
      contract.close_vault(fill_ancestor_id)
    end

    def lock_ancestor_id
      doorman.lock_ancestor
    end

    def fill_ancestor_id
      doorman.fill_ancestor
    end
  end
end
