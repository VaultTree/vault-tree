require 'spec_helper'

module VaultTree
  module V1
    describe 'VerificationKeySetter' do
      describe '#run' do
        before :each do
          contract = File.open(PathHelpers.one_two_three_contract).read 
          @exp_verification_key =  "TEST_VERIFICATION_KEY"
          opts = {party_label: "BOB", verification_key: @exp_verification_key} 
          key_setter = VerificationKeySetter.new(contract,opts)
          @returned_contract = key_setter.run
          @verification_key = Support::JSON.decode(@returned_contract)["parties"][2]["verification_key"]
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
      end
    end
  end
end
