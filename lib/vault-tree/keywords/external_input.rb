module VaultTree
  class ExternalInput < Keyword
    attr_reader :input_name

    def post_initialize(arg_array)
      @input_name = arg_array[0]
    end

    def evaluate
      validate_external_input
      contract.external_input[input_name_symbol]
    end

    private

    def id
      vault.id
    end

    def input_name_symbol
      input_name.to_sym
    end

    def validate_external_input
      input_hash_present
      input_value_not_nil
      input_value_not_empty
    end

    def input_hash_present
      raise_error unless contract.external_input.kind_of?(Hash)
    end

    def input_value_not_nil
      raise_error if (input_key_present? && nil_input_value?)
    end

    def input_value_not_empty
      raise_error if (input_key_present? && empty_input_value?)
    end

    def input_key_present?
      contract.external_input.has_key?(input_name_symbol)
    end

    def nil_input_value?
      contract.external_input[input_name_symbol].nil?
    end

    def empty_input_value?
      contract.external_input[input_name_symbol].empty?
    end

    def raise_error
      Notifications::InvalidExternalInput.new(vault_id: id).notify
      raise 'invalid external input'
    end
  end
end
