module LockSmith
  class Vault
    attr_reader :string, :id

    def initialize
      @string = empty_vault_string
      post_initialize
    end

    def post_initialize
      nil
    end

    def add_object(json)
    end

    def id 
      @id ||= generate_uuid 
    end

    def as_json
      string
    end

    def lock
      raise 'subclass must implement'
    end

    def unlock
      raise 'subclass must implement'
    end

    def generate_uuid
      UUIDTools::UUID.random_create.to_s
    end

    private

    def rack
      LockSmith::Rack.new
    end

    def empty_rack
      LockSmith::EmptyRack.new
    end

    def rack_string
      #puts deserialized
      '{}'
      #rack.as_json
    end

    def domain_class
      'vault'
    end

    def deserialized
      MultiJson.load(string)
    end

    def build_rack(str)
      Rack.new(deserialized['state'])
    end

    def empty_vault_string
      %Q[{"class":"#{domain_class}","id":"#{id}","rack":#{empty_rack.as_json}}]
    end
  end
end
