module VaultTree
  class Keyword
   attr_reader :vault, :arg_array

    def initialize(vault, arg_array)
      @vault = vault
      @arg_array = arg_array
      post_initialize(arg_array)
    end

    def contract
      vault.contract
    end

    def post_initialize(arg_array = [])
      nil
    end
  end
end
