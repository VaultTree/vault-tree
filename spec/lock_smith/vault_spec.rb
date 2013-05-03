require 'spec_helper'

module LockSmith
  describe 'Vault' do
    context 'when the vault is empty' do
      before :each do
        @vault = Vault.new
      end

      describe '#id' do
        it 'returns a uuid' do
         UUIDTools::UUID.parse(@vault.id).should be_an_instance_of(UUIDTools::UUID)
        end
      end

      describe '#as_json' do
        it 'returns the correct domain class' do
          result = MultiJson.load(@vault.as_json)
          result["class"].should == 'vault'
          UUIDTools::UUID.parse(result["id"]).should be_an_instance_of(UUIDTools::UUID)
          result["rack"].should be_an_instance_of(Hash)
          result["rack"].should be_empty
        end
      end
    end

    context 'when the vault has objects' do
      before :each do
        @vault = Vault.new
      end

      describe '#add_object' do
        it 'can adds One object its vault rack' do
          pending
        end

        it 'can add Two objects its vault rack' do
          pending
        end

      end
    end

  end
end
