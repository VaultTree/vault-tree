require 'rbnacl'
require 'rbnacl/encoders/base32'
require 'digest/sha1'

module LockSmith
  class SymmetricKey
    def initialize(opts = {})
      @vault_id = opts[:vault_id] || no_vault_id
    end

    def id
      Digest::SHA1.hexdigest(@vault_id)
    end

    def rbnacl_key
      bytes = Crypto::Random.random_bytes(Crypto::SecretBox.key_bytes)
      @rbnacl_key ||= HexEncoder.new.encode(bytes)
    end

    def as_json
      %Q[{"class":"#{domain_class}","id":"#{id}","rbnacl_key":"#{rbnacl_key}"}]
    end

    private

    def domain_class
      'symmetric_key'
    end

    def no_vault_id
      raise " #{self.class} initializer expects a vault id"
    end

  end
end
