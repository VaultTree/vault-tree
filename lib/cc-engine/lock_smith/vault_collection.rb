module LockSmith
  class VaultCollection
    attr_reader :string

    def initialize(json = nil)
      @string = json || empty
    end

    def [](id)
      vault(id) || NullVault.new
    end

    private

    def vault(id)
      Vault.new(collection[id]) if collection[id]
    end

    def collection
      ActiveSupport::JSON.decode(string)
    end

    def empty
      "[]"
    end
  end
end
