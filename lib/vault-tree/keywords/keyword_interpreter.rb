module VaultTree
  class KeywordInterpreter
    attr_reader :word, :vault
    
    def initialize(word,vault)
      @word = word 
      @vault = vault
    end

    def evaluate # start here
      begin
        keyword_class_name.new(vault, arg_array).evaluate
      rescue NameError
        raise Exceptions::UnsupportedKeyword 
      end
    end

    private

    def keyword_class_name
      instance_eval "VaultTree::#{word_base.downcase.camelize}"
    end

    def word_base
      word.gsub(/(\[.*\])/,'').strip
    end

    def arg_array
      if has_args?
        instance_eval arg_array_string
      else
        []
      end
    end

    def arg_array_string
      word.gsub(word_base,'').strip
    end

    def has_args?
      word.match(/\[/)
    end

  end
end
