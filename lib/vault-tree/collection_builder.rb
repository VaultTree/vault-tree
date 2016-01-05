module VaultTree
  class CollectionBuilder

    # combines the vaults hash with the external_input
    # hash and returns a new collections hash
    def combined_collection(vaults, external_input)
      v = vaults;
      e = nil_filter(external_input)
      e = stringify_keys(e)
      {"vaults" => v, "external_input" => e}
    end

    def stringify_keys(h)
      h.inject({}){|memo,(k,v)| memo[k.to_s] = v; memo}
    end

    # return an empty hash if external input
    # turns out to be nil
    def nil_filter(e)
      e.nil? ? {} : e
    end
  end
end
