module VaultTree
  class ExternalKey < Keyword
    attr_reader :input_name

    def post_initialize(arg_array)
      @input_name = arg_array[0]
    end

    def evaluate
      LockSmith.new(message: raw_external_input).secure_hash
    end

    private

    def raw_external_input
      KeywordInterpreter.new("EXTERNAL_INPUT['#{input_name}']", vault).evaluate
    end

  end
end
