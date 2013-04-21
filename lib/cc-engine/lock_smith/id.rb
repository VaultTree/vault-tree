module LockSmith
  class Id
    attr_reader :number
    def initialize(number)
      @number = number
    end

    def to_jbuilder
      Jbuilder.new do |number|
        number.(self,:number)
      end
    end

    def object
      'id'
    end

    def value
      to_jbuilder.target!
    end
  end
end
