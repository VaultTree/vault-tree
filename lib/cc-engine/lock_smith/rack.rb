module LockSmith
  class Rack
    attr_reader :string

    def initialize(json = nil)
      @string = json
    end

    def same_as?(rack)
      self.as_json.eql?(rack.as_json)
    end

    def as_json
      string
    end

    def type
      'rack'
    end

    def contents
      build_contents(deserialized['state'])
    end

    private

    def build_contents(state)
      state.map do |item|
        class_constant(item["object"]).send(:new, item["state"])
      end
    end

    def class_constant(obj_str)
      "#{module_name}::#{obj_str.capitalize}".constantize
    end

    def module_name
      self.class.to_s.split("::").first
    end

    def deserialized
      MultiJson.load(string)
    end
  end
end

module LockSmith
  class EmptyRack
    def as_json
      '{}'
    end
  end
end
