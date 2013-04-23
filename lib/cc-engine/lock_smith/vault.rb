module LockSmith
  class Vault
    attr_reader :string

    def initialize(json = nil)
      @string = json || empty_vault_string
    end

    def vault_rack
      build_rack(string)
    end

    def as_json
      string
    end

    def type
      raise 'subclass must implement'
    end

    def lock(key)
      raise 'subclass must implement'
    end

    def unlock(key)
      raise 'subclass must implement'
    end

    private

    def deserialized
      MultiJson.load(string)
    end

    def build_rack(str)
      Rack.new(deserialized['state'])
    end

    def empty_vault_string
      %Q[{"object":"#{type}","state":{}}]
    end
  end
end
