require 'erb'

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

    def uuid
      UUIDTools::UUID.random_create.to_s
    end
  end
end

