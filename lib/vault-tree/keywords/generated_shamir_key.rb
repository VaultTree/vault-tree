module VaultTree
  class GeneratedShamirKey < Keyword
    attr_reader :outstanding_shares, :recovery_threshold, :share_vaults

    def post_initialize(arg_array)
      @outstanding_shares = arg_array[0]
      @recovery_threshold = arg_array[1]
      @share_vaults = arg_array[2..arg_array.length]
    end

    # Generate a new Shamir key.
    #
    # Check that shares can be saved in empty vaults
    # Put the shares in their respective # vaults.
    # Gnerate and Return the key.
    #
    # @return [String] Secure Hash digest of the generated key
    def evaluate
      validate_share_vaults
      lock_away_key_shares
      generated_key
    end

    private

    def lock_away_key_shares
      c = contract
      share_vaults.each do |v|
        c = c.close_vault(v, data: data_for_vault(v) )
      end
    end

    def data_for_vault(id)
      generated_key_shares[vault_index(id)]
    end

    def vault_index(id)
      share_vaults.index(id)
    end

    def generated_key
      key_object.key
    end

    def generated_key_shares
      key_object.shares
    end

    def key_object
      @key_object ||= Crypto::GeneratedShamirKey.new(outstanding_shares: outstanding_shares, recovery_threshold: recovery_threshold)
    end

    def validate_share_vaults
      true # Add exception tests and functionality later
    end
  end
end
