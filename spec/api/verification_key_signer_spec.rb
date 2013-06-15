require 'spec_helper'

module VaultTree
  module V1
    describe 'VerificationKeySigner' do
      before :all do
        @party_label = "BOB"
        @verification_key = "TEST_VERIFICATION_KEY"
        blank_contract = File.open(PathHelpers.one_two_three_contract).read 
        opts = {party_label: @party_label, verification_key: @verification_key} 
        @contract = VerificationKeySetter.new(blank_contract,opts).run
        @private_signing_key = LockSmith::SigningKeyPair.new().signing_key
        @exp_signature = LockSmith::DigitalSignature.new(message: @verification_key, signing_key: @private_signing_key).generate
      end

      describe '#run' do

        before :each do
          @key_signer = VerificationKeySigner.new(@contract, party_label: @party_label, private_signing_key: @private_signing_key)
          @returned_contract = VerificationKeySigner.new(@contract, party_label: @party_label, private_signing_key: @private_signing_key).run
        end

        it 'returns the contract as a json string' do
          @returned_contract.should be_an_instance_of(String)
        end

        it 'the verification key digital signature is present in the signing block' do
          @signed_verification_key = Support::JSON.decode(@returned_contract)["signature_blocks"][1]["signed_verification_key"]
          @signed_verification_key.should == @exp_signature
        end
      end
    end
  end
end
