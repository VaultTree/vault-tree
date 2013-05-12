FactoryGirl.define do
  factory :dummy_contract, class: VaultTree::Contract do
    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.contract_header = FactoryGirl.create(:contract_header)
      contract.genesis_vault = FactoryGirl.create(:genesis_vault)
    end
  end
end
