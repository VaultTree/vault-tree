require 'spec_helper'

module VaultTree
  describe 'Party' do
    describe '#set_' do
      before :each do
        @contract = FactoryGirl.create(:contract)
        @party = @contract.parties.first
      end

      context '_label' do
        before :each do
          @party.set_label('TEST_LABEL')
        end

        it 'sets the label' do
          Support::JSON.decode(@contract.as_json)["parties"].first["label"]
        end
      end

      context '_verification_key' do
        before :each do
          @party.set_verification_key('TEST_VERIFICATION_KEY')
        end

        it 'sets the verification_key' do
          Support::JSON.decode(@contract.as_json)["parties"].first["verification_key"]
        end
      end

      context '_public_encryption_key' do
        before :each do
          @party.set_public_encryption_key('TEST_PUB_ENC_KEY')
        end

        it 'sets the verification_key' do
          Support::JSON.decode(@contract.as_json)["parties"].first["public_encryption_key"]
        end
      end
    end

    describe '#create' do

      before(:each) do
        @party = FactoryGirl.create(:party)
      end

      it 'is properly created' do
        @party.should be_an_instance_of(Party)
      end
    end
  end
end
