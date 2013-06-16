require 'spec_helper'

module VaultTree
  module V1
    describe 'PartyAttributeSetter' do
      describe '#run' do
        context 'valid input' do
          before :each do
            @contract = FactoryGirl.create(:contract_with_bob).as_json
          end

          context 'for verification_key' do

            before :each do
              @opts = {attribute: :verification_key, party_label: "BOB"}
              @returned_contract = PartyAttributeSetter.new(@contract,@opts).run
            end

            it 'returns the contract as a json string' do
              pending
              @returned_contract.should be_an_instance_of(String)
            end

            it 'the attribute has been set with the proper value' do
              pending
              @attr_value.should == @expected_attr_value
            end
          end

          context 'for label' do
            it 'the attribute has been set with the proper value' do
              pending
              @attr_value.should == @expected_attr_value
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
