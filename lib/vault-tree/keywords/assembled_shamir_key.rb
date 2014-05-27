module VaultTree
  class AssembledShamirKey < Keyword

    attr_reader :arg_array

    def post_initialize(arg_array)
      @arg_array = arg_array
    end

    # Assemble a Shamir key from existing shares. Get the shares from their respective
    # vaults. Assemble and Return the key.
    #
    # @return [String] Secure Hash digest of the generated key
    def evaluate
      retrieve_key_shares
      assembled_key
    end

    private

    def assembled_key
      key_object.assemble
    end

    def collected_shares
      @collected_shares
    end

    def vault_ids
      arg_array
    end

    def retrieve_key_shares
      @collected_shares = []
      vault_ids.each{|id| @collected_shares << contract.open_vault(id) }
      return @collected_shares
    end

    def key_object
      @key_object ||= Crypto::AssembledShamirKey.new(key_shares: collected_shares)
    end

  end
end
