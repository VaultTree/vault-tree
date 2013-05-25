require 'spec_helper'

describe 'Party' do
  describe '#create' do

    before(:each) do
      @party = FactoryGirl.create(:party)
    end

    it 'is properly created' do
      @party.should be_an_instance_of(VaultTree::Party)
    end

    it 'has_many vaults as a custodian' do
      @party.vaults.length.should be > 1
    end

    it 'can access its vaults' do
      @party.vaults.first.should be_an_instance_of(VaultTree::Vault)
    end

    it 'each vault is different' do
      f = @party.vaults.first.label
      l = @party.vaults.last.label
      f.should_not == l
    end

  end
end
