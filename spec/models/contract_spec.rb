require 'spec_helper'

module VaultTree
  describe 'Contract' do

    describe '.import | #as_json' do
      before(:each) do
        @json = File.open(PathHelpers.one_two_three_contract).read
        @contract = Contract.import(@json)
      end

      it 'the json matches after input and output' do
        @contract.as_json.should == @json
      end

      it 'the compressed string checksums should match' do
        pending
      end
    end

    describe '.import' do
      it 'returns a null contract for invalid json' do
        pending
      end
    end

    describe '#create' do

      before(:each) do
        @contract = FactoryGirl.create(:contract)
      end

      it 'has_many vaults' do
        @contract.vaults.length.should be > 1
      end

      it 'can access its vaults' do
        @contract.vaults.first.should be_an_instance_of(Vault)
      end

      it 'each vault is different' do
        f = @contract.vaults.first.label
        l = @contract.vaults.last.label
        f.should_not == l
      end

      it 'has_many parties' do
        @contract.parties.length.should be > 1
      end

      it 'can access its parties' do
        @contract.parties.first.should be_an_instance_of(Party)
      end

      it 'each party is different' do
        f = @contract.parties.first.party_number
        l = @contract.parties.last.party_number
        f.should_not == l
      end
    end
  end
end
