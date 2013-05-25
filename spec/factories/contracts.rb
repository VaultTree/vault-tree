FactoryGirl.define do
  factory :contract, class: VaultTree::Contract do
    specification ""
    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.parties << FactoryGirl.create(:party)
      contract.parties  << FactoryGirl.create(:party)
    end
  end
end
