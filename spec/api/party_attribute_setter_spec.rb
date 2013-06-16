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
              @expected_attr_value = "TEST_PARTY_ATTR"
              @opts = {attribute: :verification_key, value: @expected_attr_value, party_label: "BOB"}
              @returned_contract = PartyAttributeSetter.new(@contract, @opts).run
              @returned_contract_hash =  Support::JSON.decode(@returned_contract)
            end

            it 'returns the contract as a json string' do
              @returned_contract.should be_an_instance_of(String)
            end

            it 'the attribute has been set with the proper value' do
              @attr_value = @returned_contract_hash["parties"].select{|p| p["label"] == "BOB"}.first["verification_key"]
              @attr_value.should == @expected_attr_value
            end
          end

          context 'for label' do
            before :each do
              @expected_attr_value = "TEST_PARTY_ATTR"
              @opts = {attribute: :label, value: @expected_attr_value, party_label: "BOB"}
              @returned_contract = PartyAttributeSetter.new(@contract, @opts).run
              @returned_contract_hash =  Support::JSON.decode(@returned_contract)
            end

            it 'the attribute has been set with the proper value' do
              @attr_value = @returned_contract_hash["parties"].select{|p| p["label"] == "#{@expected_attr_value}"}.first["label"]
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
