require 'spec_helper'

module VaultTree
  module V1
    describe 'VerificationKeySetter' do
      describe '#run' do
        before :all do
          @contract = FactoryGirl.create(:contract_with_bob).as_json
          @exp_verification_key =  "TEST_VERIFICATION_KEY"
        end

        before :each do
          opts = {party_label: "BOB", verification_key: @exp_verification_key} 
          @returned_contract = VerificationKeySetter.new(@contract,opts).run
          @verification_key = Support::JSON.decode(@returned_contract)["parties"].last["verification_key"]
        end

        it 'returns the contract as a json string' do
          @returned_contract.should be_an_instance_of(String)
        end

        it 'the returned contract has a verification key' do
          @verification_key.should be_an_instance_of(String)
        end

        it 'the verification key has been set with the proper value' do
          @verification_key.should == @exp_verification_key
        end

        it 'the returned contract should have only 3 parties' do
          Support::JSON.decode(@returned_contract)["parties"].length.should == 3
        end
      end
    end
  end
end
