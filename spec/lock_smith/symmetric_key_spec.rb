require 'spec_helper'

module LockSmith
  describe 'SymmetricKey' do

    describe '#id' do
      before :each do
        @vault_id = 'MOCK_VAULT_UUID'
        @vault_id_checksum = Digest::SHA1.hexdigest(@vault_id)
        @symmetric_key = SymmetricKey.new(vault_id: @vault_id)
      end

      it 'the symmetric key id is the sha1 of its vault id' do
        @symmetric_key.id.should == @vault_id_checksum
      end
    end

    describe '#rbnacl_key' do

      context 'when initialized without a rbnacl key value' do
        before :each do
          @vault_id = 'MOCK_VAULT_UUID'
          @vault_id_checksum = Digest::SHA1.hexdigest(@vault_id)
          @symmetric_key = SymmetricKey.new(vault_id: @vault_id)
        end

        it 'returns a new random value' do
          @symmetric_key.rbnacl_key.nil?.should == false
          @symmetric_key.rbnacl_key.kind_of?(String).should == true
        end
      end
    end

    describe '#as_json' do
      before :each do
        @vault_id = 'MOCK_VAULT_UUID'
        @vault_id_checksum = Digest::SHA1.hexdigest(@vault_id)
        @symmetric_key = SymmetricKey.new(vault_id: @vault_id)
      end

      it 'returns its domain class as a json attribute' do
        ActiveSupport::JSON.decode(@symmetric_key.as_json)["class"].should == "symmetric_key"
      end

      it 'returns the correct id as json' do
        ActiveSupport::JSON.decode(@symmetric_key.as_json)["id"].should == @symmetric_key.id
      end

      it 'returns the rbnacl_key as json' do
        ActiveSupport::JSON.decode(@symmetric_key.as_json)["rbnacl_key"].should == @symmetric_key.rbnacl_key
      end

    end
  end
end

class HexEncoder < Crypto::Encoder
  register :hex

  # Encode a message as hexadecimal
  def encode(bytes)
    bytes.to_s.unpack("H*").first
  end

  # Decode a message from hexadecimal
  def decode(hex)
    [hex.to_s].pack("H*")
  end
end


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
