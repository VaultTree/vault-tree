require 'rbnacl'
require 'rbnacl/encoders/base32'
require 'digest/sha1'

module LockSmith
  class SymmetricKey
    def initialize(opts = {})
      @vault_id = opts[:vault_id]
      @rbnacl_key = opts[:rbnacl_key] 
    end

    def vault_id
      @vault_id
    end

    def rbnacl_key
      bytes = Crypto::Random.random_bytes(Crypto::SecretBox.key_bytes)
      @rbnacl_key ||= HexEncoder.new.encode(bytes)
    end

    def as_json
      %Q[{"class":"#{domain_class}","vault_id":"#{vault_id}","rbnacl_key":"#{rbnacl_key}"}]
    end

    private

    def domain_class
      'symmetric_key'
    end
  end
end
