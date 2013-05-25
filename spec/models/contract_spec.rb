require 'spec_helper'

describe 'Contract' do
  describe '#create' do

    before(:each) do
      @contract = FactoryGirl.create(:contract)
    end

    it 'has_many vaults' do
      @contract.vaults.length.should be > 1
    end

    it 'can access its vaults' do
      @contract.vaults.first.should be_an_instance_of(VaultTree::Vault)
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
      @contract.parties.first.should be_an_instance_of(VaultTree::Party)
    end

    it 'each party is different' do
      f = @contract.parties.first.party_number
      l = @contract.parties.last.party_number
      f.should_not == l
    end
  end
end
