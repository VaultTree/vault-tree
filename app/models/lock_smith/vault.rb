require 'active_support'
module LockSmith
  class Vault
    attr_reader :string

    def initialize(json = nil)
      @string = json || vault_string(empty_contents_json)
      @contents = []
      post_initialize
    end

    def add_object(json)
      contents.push(MultiJson.load(json))
      @string = vault_string(contents_as_json)
      return self
    end

    def id 
      @id ||= generate_uuid 
    end

    def as_json
      string
    end

    def lock(key = nil)
      raise 'subclass must implement'
    end

    def unlock(key = nil)
      raise 'subclass must implement'
    end

    private
    attr_accessor :contents

    def post_initialize
      nil
    end

    def generate_uuid
      UUIDTools::UUID.random_create.to_s
    end

    def contents_as_json
      VaultTree::Support::JSON.encode(contents)
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
