require 'spec_helper'

module LockSmith
  describe 'SymmetricKey' do

    describe '#vault_id' do
      before :each do
        @vault_id = 'MOCK_VAULT_UUID'
        @symmetric_key = SymmetricKey.new(vault_id: @vault_id)
      end

      it 'returns the proper vault_id' do
        @symmetric_key.vault_id.should == @vault_id
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

      it 'returns the correct vault id as json' do
        ActiveSupport::JSON.decode(@symmetric_key.as_json)["vault_id"].should == @symmetric_key.vault_id
      end

      it 'returns the rbnacl_key as json' do
        ActiveSupport::JSON.decode(@symmetric_key.as_json)["rbnacl_key"].should == @symmetric_key.rbnacl_key
      end

    end
  end
end
