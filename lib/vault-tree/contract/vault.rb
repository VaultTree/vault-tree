module VaultTree
  class Vault
    attr_reader :id, :properties, :contract

    def initialize(id, properties, contract)
      @id = id
      @properties = properties
      @contract = contract
    end

    def close
      begin
        @properties['contents'] = doorman.lock_contents
        self
      rescue RbNaCl::CryptoError => e
        raise Exceptions::FailedLockAttempt.new(e, vault_id: id)
      end
    end

    def open
      begin
        contract.close_vault(id)
        doorman.unlock_contents
      rescue RbNaCl::CryptoError => e
        raise Exceptions::FailedUnlockAttempt.new(e, vault_id: id)
      end
    end

    def doorman
      @doorman ||= Doorman.new(vault: self)
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
