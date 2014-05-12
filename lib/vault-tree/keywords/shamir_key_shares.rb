module VaultTree
  class ShamirKeyShares < Keyword
    attr_reader :outstanding_shares, :recovery_threshold

    def post_initialize(arg_array)
      @outstanding_shares = arg_array[0]
      @recovery_threshold = arg_array[1]
    end

    def evaluate
      Crypto::ShamirKeyShares.new(
        outstanding_shares: outstanding_shares,
        recovery_threshold: recovery_threshold
      ).generate
    end

  end
end
