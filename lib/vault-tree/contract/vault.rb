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
      @properties['contents'] = locked_contents
      self
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
      lock_with_key_or_contents?
    end

    def has_fill_ancestor?
      fill_with_key_or_contents?
    end

    def lock_with_key_or_contents?
      (locking_word_base == 'CONTENTS') || (locking_word_base == 'KEY')
    end

    def locking_word_base
      KeywordInterpreter.new(lock_with,self).word_base
    end

    def fill_with_key_or_contents?
      (filling_word_base == 'CONTENTS') || (filling_word_base == 'KEY')
    end

    def filling_word_base
      KeywordInterpreter.new(fill_with,self).word_base
    end

    def lock_ancestor_id
      lock_with.extract_ancestor_id if has_lock_ancestor?
    end

    def fill_ancestor_id
      fill_with.extract_ancestor_id if has_fill_ancestor?
    end
  end
end
