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
          result["contents"].should be_an_instance_of(Array)
          result["contents"].should be_empty
        end
      end
    end

    context 'when the vault has objects' do
      describe '#add_object' do
        before :each do
          @vault = Vault.new
        end

        it 'can add One object its vault contents' do
           @vault.add_object(Fixtures.wallet_address)
           ActiveSupport::JSON.decode(@vault.as_json)["contents"][0]["class"].should == "wallet_address"
        end

        it 'can add Two objects its vault contents' do
           @vault.add_object(Fixtures.wallet_address)
           ActiveSupport::JSON.decode(@vault.as_json)["contents"][0]["class"].should == "wallet_address"
           @vault.add_object(Fixtures.wallet_address_alt)
           ActiveSupport::JSON.decode(@vault.as_json)["contents"][1]["class"].should == "wallet_address_alt"
        end

      end
    end

  end
end
