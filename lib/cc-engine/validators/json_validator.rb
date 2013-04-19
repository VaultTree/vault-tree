require 'json'
module Engine
  module Validators
    class JsonValidator
      attr_reader :json_input

      def initialize(json_input)
        @json_input = json_input 
      end

      def valid?
        JSON.parse(json_input)  
        return true  
      rescue JSON::ParserError  
        return false  
      end

    end
  end
end
