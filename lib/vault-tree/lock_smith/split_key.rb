module VaultTree
  class SplitKeyCrypto
    attr_reader :required_keys

    def initialize(opts)
      @required_keys = opts[:required_keys]
    end

    def generate
      secure_hash key_digests.join('')
    end

    private

    def key_digests
      required_keys.map{|k| secure_hash(k) }
    end

    def secure_hash(s)
      LockSmith.new(message: s).secure_hash
    end
  end
end
