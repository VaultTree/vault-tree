require 'spec_helper'

module VaultTree
  module V1
    describe 'VerificationKeySigner' do

      describe '#run' do

        before :all do
          @contract = FactoryGirl.create(:contract_with_bob_vk).as_json
          @party_label = "BOB"
          @verification_key = "TEST_VERIFICATION_KEY"
          @private_signing_key = LockSmith::SigningKeyPair.new().signing_key
          @expected_signature = LockSmith::DigitalSignature.new(message: @verification_key, signing_key: @private_signing_key).generate
        end

        before :each do
          @returned_contract = VerificationKeySigner.new(@contract, party_label: @party_label, private_signing_key: @private_signing_key).run
        end

        it 'returns the contract as a json string' do
          @returned_contract.should be_an_instance_of(String)
        end

        it 'the verification key digital signature is present in the signing block' do
          @signed_verification_key = Support::JSON.decode(@returned_contract)["signature_blocks"].last["signed_verification_key"]
          @signed_verification_key.should == @expected_signature
        end
      end
    end
  end
end
