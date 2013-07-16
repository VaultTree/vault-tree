require 'spec_helper'

module VaultTree
  module V2
    describe 'ContractModifier' do
      before :all do
        @alice_public_data = Support::JSON.decode(AutoBots::Alice.new.public_data)
        @alice_private_data = Support::JSON.decode(AutoBots::Alice.new.private_data)
        @bob_public_data = Support::JSON.decode(AutoBots::Bob.new.public_data)
        @blank_contract = FactoryGirl.build(:blank_contract)
      end

      describe '#build' do
        it 'returns a contract' do
          @contract_modifier = ContractModifier.new(contract: @blank_contract, changes: @bob_public_data)
          @contract_modifier.build.should be_an_instance_of(Contract)
        end

        it 'can add public data' do
          @contract_modifier = ContractModifier.new(contract: @blank_contract, changes: @alice_public_data)
          @contract = @contract_modifier.build
          @contract.public_data_present?('alice').should be true
        end

        it 'can add public data from 2 parties' do
          @contract_modifier = ContractModifier.new(contract: @blank_contract, changes: @alice_public_data)
          @contract = @contract_modifier.build
          @contract_modifier = ContractModifier.new(contract: @contract, changes: @bob_public_data)
          @contract = @contract_modifier.build
          @contract.public_data_present?('alice').should be true
          @contract.public_data_present?('bob').should be true
        end

        it 'can add private data' do
          @contract_modifier = ContractModifier.new(contract: @blank_contract, changes: @alice_private_data)
          @contract = @contract_modifier.build
          @contract.private_data_present?('alice').should be true
        end

        it 'can add public data from 2 parties and private data from 1 party' do
          @contract_modifier = ContractModifier.new(contract: @blank_contract, changes: @alice_public_data)
          @contract = @contract_modifier.build
          @contract_modifier = ContractModifier.new(contract: @blank_contract, changes: @alice_private_data)
          @contract = @contract_modifier.build
          @contract_modifier = ContractModifier.new(contract: @contract, changes: @bob_public_data)
          @contract = @contract_modifier.build
          @contract.public_data_present?('alice').should be true
          @contract.public_data_present?('bob').should be true
          @contract.private_data_present?('alice').should be true
        end
      end
    end
  end
end
