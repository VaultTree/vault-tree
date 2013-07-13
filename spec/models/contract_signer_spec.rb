require 'spec_helper'

module VaultTree
  describe 'ContractSigner' do
    before :all do
      @json_contract = File.open(VaultTree::PathHelpers.one_two_three_020).read
      @alice = AutoBots::Alice.new
      @alice_public_data = @alice.public_data
      @json_contract = ContractBuilder.new(json_contract: @json_contract, json_party_properties: @alice_public_data).build
      @alice_private_data = @alice.private_data
      @json_contract = ContractBuilder.new(json_contract: @json_contract, json_party_properties: @alice_private_data).build
    end

    describe '#sign' do
      before :each do
        @contract_signer = ContractSigner.new(json_contract: @json_contract)
      end

      it 'address signature has been populated' do
        @json = @contract_signer.sign
        address_sig = Support::JSON.decode(@json)['parties']['alice']['public_signatures']['address']['signature']
        address_sig.should be_an_instance_of(String)
        address_sig.empty?.should be false
      end

      it 'verification_key signature has been populated' do
        @json = @contract_signer.sign
        verification_key_sig = Support::JSON.decode(@json)['parties']['alice']['public_signatures']['verification_key']['signature']
        verification_key_sig.should be_an_instance_of(String)
        verification_key_sig.empty?.should be false
      end

      it 'public signatures with empty values have been left blank' do
        pending 'NYI'
      end

      it 'an exception is thrown if there is more than 1 private signing key found' do
        pending 'NYI'
      end
    end

  end
end
