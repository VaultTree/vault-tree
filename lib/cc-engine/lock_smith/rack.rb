module LockSmith
  class Rack
    attr_reader :contents

    def initialize(opts = {})
      @contents = opts[:contents] 
    end

    def same_as?(rack)
      same = false
      contents.each{|i| same = same_item?(i, rack.contents[contents.index(i)])}
      return same
    end

    private

    def same_item?(first,second)
      first.clear_text.eql?(second.clear_text)
    end
  end
end
