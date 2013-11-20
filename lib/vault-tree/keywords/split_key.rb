module VaultTree
  class SplitKey < Keyword
    attr_reader :required_key_vaults

    def post_initialize(arg_array)
      @required_key_vaults = arg_array
    end

    def evaluate
      LockSmith::SplitKey.new(required_keys: required_keys).generate
    end

    private

    def required_keys
      required_key_vaults.map {|id| contract.retrieve_contents(id) }
    end
  end
end
