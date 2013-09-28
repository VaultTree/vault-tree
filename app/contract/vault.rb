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

    def retrieve_contents
      unlocked_contents
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

    def empty?
      contents.empty?
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
      contract.set_vault_contents(id, locked_contents)
    end

    def unlocked_contents
      Doorman.new(self).unlocked_contents
    end

    def locked_contents
      Doorman.new(self).locked_contents
    end

    def close_lock_ancestor
      contract.close_vault(lock_ancestor_id)
    end

    def close_fill_ancestor
      contract.close_vault(fill_ancestor_id)
    end

    def has_lock_ancestor?
      lock_with.include? 'CONTENTS'
    end

    def has_fill_ancestor?
      fill_with.include? 'CONTENTS'
    end

    def lock_ancestor_id
      lock_with.gsub(/(CONTENTS\[\')|(\'\])/,'').strip if has_lock_ancestor?
    end

    def fill_ancestor_id
      fill_with.gsub(/(CONTENTS\[\')|(\'\])/,'').strip if has_fill_ancestor?
    end
  end
end
