require 'active_support'
module LockSmith
  class Vault
    attr_reader :string, :id

    def initialize(encrypted_json = nil)
      @string = encrypted_json || vault_string(empty_contents_json)
      @contents = []
      post_initialize
    end

    def post_initialize
      nil
    end

    def add_object(json)
      contents.push(MultiJson.load(json))
      @string = vault_string(contents_as_json)
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

    def deserialized
      MultiJson.load(string)
    end

    private
    attr_accessor :contents

    def contents_as_json
      ActiveSupport::JSON.encode(contents)
    end

    def domain_class
      'vault'
    end

    def empty_contents_json
      '[]'
    end

    def vault_string(contents_json)
      %Q[{"class":"#{domain_class}","id":"#{id}","contents":#{contents_json}}]
    end
  end
end
