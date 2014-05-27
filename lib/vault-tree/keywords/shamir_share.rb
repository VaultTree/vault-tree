module VaultTree
  class ShamirShare < Keyword
    attr_reader :share_collection_vault, :collection_index

    def post_initialize(arg_array)
      @share_collection_vault = arg_array[0]
      @collection_index = arg_array[1]
    end

    def evaluate
      share_collection[collection_index]
    end

    def share_collection
      JSON.parse contract.open_vault(share_collection_vault)
    end
  end
end
