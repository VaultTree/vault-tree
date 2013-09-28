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
      close_fill_ancestor close_lock_ancestor(contract)
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

    def close_lock_ancestor(c)
      lock_ancestor_vault(c).close
    end

    def close_fill_ancestor(c)
      fill_ancestor_vault(c).close
    end

    def lock_ancestor_vault(c)
      if has_lock_ancestor?
        Vault.new(lock_ancestor_id,c.vaults[lock_ancestor_id], c)
      else
        CommonAncestorVault.new(c)
      end
    end

    def fill_ancestor_vault(c)
      if has_fill_ancestor?
        Vault.new(fill_ancestor_id, c.vaults[fill_ancestor_id], c)
      else
        CommonAncestorVault.new(c)
      end
    end

    def has_lock_ancestor?
      lock_with.include? 'CONTENTS'
    end

    def has_fill_ancestor?
      fill_with.include? 'CONTENTS'
    end

    def lock_ancestor_id
      lock_with.gsub(/(CONTENTS\[\')|(\'\])/,'').strip
    end

    def fill_ancestor_id
      fill_with.gsub(/(CONTENTS\[\')|(\'\])/,'').strip
    end
  end
end
