require 'spec_helper'

module LockSmith
  describe 'SymmetricKey' do
    describe '#as_json' do
      before :each do
        @vault_id = 'MOCK_VAULT_UUID'
        @vault_id_checksum = Digest::SHA1.hexdigest(@vault_id)
        @symmetric_key = SymmetricKey.new(vault_id: @vault_id)
      end

      it 'returns its domain class as a json attribute' do
        ActiveSupport::JSON.decode(@symmetric_key.as_json)["class"].should == "symmetric_key"
      end

      it 'the key id is the sha1 of its vault id' do
        ActiveSupport::JSON.decode(@symmetric_key.as_json)["id"].should == @vault_id_checksum
      end
    end

    describe '#rbnacl_key' do
      it 'pends' do
        pending
      end
    end
  end
end

require 'rbnacl'
require 'digest/sha1'

module LockSmith
  class SymmetricKey
    def initialize(opts = {})
      @vault_id = opts[:vault_id] || no_vault_id
    end

    def as_json
      %Q[{"class":"#{domain_class}","id":"#{id}"}]
    end

    def id
      Digest::SHA1.hexdigest(@vault_id)
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
