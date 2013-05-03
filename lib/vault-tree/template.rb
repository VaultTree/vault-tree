require 'erb'
require 'uuidtools'
require 'digest/sha1'

module VaultTree
  class Template
    def initialize
      post_initialize
    end

    def post_initialize
      nil
    end

    def generate_contract
      ERB.new(template_erb).result(binding)
    end

    def generate_uuid
      UUIDTools::UUID.random_create.to_s
    end

    def vault_id_checksum(id)
      Digest::SHA1.hexdigest(id)
    end
  end
end

