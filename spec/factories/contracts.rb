FactoryGirl.define do
  factory :dummy_contract, class: VaultTree::Contract do
    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.contract_header = FactoryGirl.create(:contract_header)
    end
  end
end
