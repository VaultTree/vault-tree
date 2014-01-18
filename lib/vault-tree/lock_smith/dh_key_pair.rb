module VaultTree
  class DHKeyPair
    attr_reader :public_key, :secret_key

    def initialize(opts)
      @public_key = opts[:public_key]
      @secret_key = opts[:secret_key]
    end
  end
end
