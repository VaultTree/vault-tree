module VaultTree
  class VaultKey
    attr_reader :k

    def initialize(k)
      @k = k
    end

    def secret
      asymmetric? ? k.secret_key : k
    end

    def public
      asymmetric? ? k.public_key : nil
    end

    def asymmetric?
      k.kind_of?(DHKeyPair)
    end
  end
end
