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
      end

      context 'with alice then bobs public data' do

        before :each do
          @alice = AutoBots::Alice.new
          @alice_public_data = @alice.public_data
          @json = ContractBuilder.new(json_contract: @json_contract, json_party_properties: @alice_public_data).build
          @bob = AutoBots::Bob.new
          @bob_public_data = @bob.public_data
          @json = ContractBuilder.new(json_contract: @json, json_party_properties: @bob_public_data).build
        end

        it 'has alices public data' do
          Support::JSON.decode(@json)['parties']['alice']['public_data']['address'].should == @alice.address
          Support::JSON.decode(@json)['parties']['alice']['public_data']['verification_key'].should == @alice.verification_key
          Support::JSON.decode(@json)['parties']['alice']['public_data']['public_encryption_key'].should == @alice.public_encryption_key
        end

        it 'has bobs public data' do
          Support::JSON.decode(@json)['parties']['bob']['public_data']['address'].should == @bob.address
          Support::JSON.decode(@json)['parties']['bob']['public_data']['verification_key'].should == @bob.verification_key
          Support::JSON.decode(@json)['parties']['bob']['public_data']['public_encryption_key'].should == @bob.public_encryption_key
        end
      end

      context 'with alice and bobs public data, and alices private data' do

        before :each do
          @alice = AutoBots::Alice.new
          @alice_public_data = @alice.public_data
          @json = ContractBuilder.new(json_contract: @json_contract, json_party_properties: @alice_public_data).build
          @bob = AutoBots::Bob.new
          @bob_public_data = @bob.public_data
          @json = ContractBuilder.new(json_contract: @json, json_party_properties: @bob_public_data).build
          @alice_private_data  = @alice.private_data
          @json = ContractBuilder.new(json_contract: @json, json_party_properties: @alice_private_data).build
        end

        it 'has alices public data' do
          Support::JSON.decode(@json)['parties']['alice']['public_data']['address'].should == @alice.address
          Support::JSON.decode(@json)['parties']['alice']['public_data']['verification_key'].should == @alice.verification_key
          Support::JSON.decode(@json)['parties']['alice']['public_data']['public_encryption_key'].should == @alice.public_encryption_key
        end

        it 'has bobs public data' do
          Support::JSON.decode(@json)['parties']['bob']['public_data']['address'].should == @bob.address
          Support::JSON.decode(@json)['parties']['bob']['public_data']['verification_key'].should == @bob.verification_key
          Support::JSON.decode(@json)['parties']['bob']['public_data']['public_encryption_key'].should == @bob.public_encryption_key
        end

        it 'has alices private data' do
          Support::JSON.decode(@json)['parties']['alice']['private_data']['decryption_key'].should == @alice.decryption_key
          Support::JSON.decode(@json)['parties']['alice']['private_data']['signing_key'].should == @alice.signing_key
        end
      end

    end
  end
end
