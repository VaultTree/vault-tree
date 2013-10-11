module VaultTree
  class NullVault

    def properties
      {}
    end

    def id
      nil
    end

    def close
      self
    end
  end
end
