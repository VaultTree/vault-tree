require 'spec_helper'

module VaultTree
  describe 'ContractBuilder' do
    before :all do
      @json_contract = File.open(VaultTree::PathHelpers.one_two_three_020).read
      @contract_builder = ContractBuilder.new(json: @json)
    end

    describe '#build' do
      context 'with alice public data' do
        before :each do
          @alice = AutoBots::Alice.new
          @alice_public_data = @alice.public_data
          @json = ContractBuilder.new(json_contract: @json_contract, json_party_properties: @alice_public_data).build
        end

        it 'adds alices public data' do
          Support::JSON.decode(@json)['parties']['alice']['public_data']['address'].should == @alice.address
          Support::JSON.decode(@json)['parties']['alice']['public_data']['verification_key'].should == @alice.verification_key
          Support::JSON.decode(@json)['parties']['alice']['public_data']['public_encryption_key'].should == @alice.public_encryption_key
        end

        context 'with bob public data' do
          context 'with bob private data' do
            it 'does something' do
              pending
            end
          end
        end
      end
    end
  end
end
