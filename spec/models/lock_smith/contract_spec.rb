require 'spec_helper'

describe 'Contract' do
  describe '#create' do

    before(:each) do
      @contract = FactoryGirl.create(:dummy_contract)
    end

    it 'has_many vaults' do
      @contract.vaults.length.should be > 1
    end

    it 'each vault is different' do
      f = @contract.vaults.first.content 
      l = @contract.vaults.last.content 
      f.should_not == l
    end

    it 'has_one contract_header' do
      @contract.contract_header.should be_an_instance_of(VaultTree::ContractHeader)
    end

    it 'has_one genesis_vault' do
      @contract.genesis_vault.should be_an_instance_of(VaultTree::GenesisVault)
    end
  end
end
