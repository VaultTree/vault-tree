require 'spec_helper'

module FactoryHelpers
  def self.random_hex
    (0...4).map{ ('a'..'z').to_a[rand(26)] }.join
  end
end

FactoryGirl.define do

  factory :vault, class: VaultTree::Vault do
    content "ENCRYPTED_CONTENT-#{FactoryHelpers.random_hex}"
  end

  factory :genesis_vault, class: VaultTree::GenesisVault do
    content "ENCRYPTED_CONTENT-random_hex"
  end

  factory :contract_header, class: VaultTree::ContractHeader do
    content "HEADER_CONTENT"
  end
end

FactoryGirl.define do
  factory :contract_with_vaults, class: VaultTree::Contract do
    #after(:create) do |contract|
      #contract.genesis_vault << FactoryGirl.create(:genesis_vault)
    #end

    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.contract_header = FactoryGirl.create(:contract_header)
      contract.genesis_vault = FactoryGirl.create(:genesis_vault)
    end
  end 
end

describe 'Contract' do
  describe '#create' do

    before(:each) do
      @contract = FactoryGirl.create(:contract_with_vaults)
    end

    it 'has_many vaults' do
      @contract.vaults.length.should be > 1
    end

    it 'each vault is different' do
      pending
    end

    it 'has_one contract_header' do
      @contract.contract_header.should be_an_instance_of(VaultTree::ContractHeader)
    end

    it 'has_one genesis_vault' do
      @contract.genesis_vault.should be_an_instance_of(VaultTree::GenesisVault)
    end
  end
end
