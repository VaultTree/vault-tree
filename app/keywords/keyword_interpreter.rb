module VaultTree
  module V3
    class KeywordInterpreter
      attr_reader :word, :contract
      
      def initialize(word,contract)
        @word = word 
        @contract = contract
      end

      def evaluate # start here
        keyword_class_name.new(contract, keyword_arg).evaluate
      end

      private

      def keyword_class_name
        "VaultTree::V3::#{word_base.downcase.camelize}".constantize
      end

      def word_base
        word.match(/[A-Z_]*/).to_s
      end

      def keyword_arg
        word.gsub(/(#{word_base}\[\')|(\'\])/,'').strip if has_args?
      end

      def has_args?
        word.match(/\[/)
      end

    end
  end
end
