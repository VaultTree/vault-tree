module LockSmith
  class Rack
    attr_reader :contents

    def initialize(opts = {})
      @contents = opts[:contents] 
    end

    def same_as?(rack)
      contents.each do |i|
        i_1 = i
        i_2 = rack.contents[contents.index(i)]
        return false unless same_item?(i_1,i_2)
      end
      return true
    end

    def as_json
      to_jbuilder.target!
    end

    def object
      'vault_rack'
    end

    def to_jbuilder
      Jbuilder.new do |json|
        json.object object
        json.value do
          json.array! contents do |i|
            json.object i.object
            json.value i.to_jbuilder
          end
        end
      end
    end

    private

    def same_item?(first,second)
      first.value.eql?(second.value)
    end
  end
end
