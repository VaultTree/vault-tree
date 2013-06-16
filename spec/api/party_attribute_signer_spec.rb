require 'spec_helper'

module VaultTree
  module V1
    describe 'PartyAttributeSigner' do
      describe '#run' do
        before :all do
          @contract = FactoryGirl.create(:contract_with_bob_vk).as_json
          @party_label = "BOB"
          @attr = :verification_key
          @private_signing_key = LockSmith::SigningKeyPair.new().signing_key
          @verification_key = "TEST_VERIFICATION_KEY"
          @expected_signature = LockSmith::DigitalSignature.new(message: @verification_key, signing_key: @private_signing_key).generate
        end

        context 'valid input' do
          before :each do
            @returned_contract = PartyAttributeSigner.new(@contract, party_label: @party_label, attribute: @attr, private_signing_key: @private_signing_key).run
            @returned_contract_hash = Support::JSON.decode(@returned_contract)
          end

          context 'for verification_key' do
            it 'returns the contract as a json string' do
              @returned_contract.should be_an_instance_of(String)
            end

            it 'proper digital signature is present in the signing block'  do
              @attr_sig = @returned_contract_hash["signature_blocks"].select{|p| p["party_label"] == "BOB"}.first["signed_verification_key"]
              @attr_sig.should == @expected_signature
            end
          end
        end

        context 'invalid input' do
          context 'for non_existant_attribute' do
            it 'it raises an unsuppored attr exception' do
              pending
            end
          end
        end
      end
    end
  end
end
