FactoryGirl.define do
  factory :dummy_contract, class: VaultTree::Contract do
    after(:create) do |contract|
      contract.nodes << FactoryGirl.create(:node)
      contract.nodes << FactoryGirl.create(:node)
      contract.nodes << FactoryGirl.create(:node)
      contract.contract_header = FactoryGirl.create(:contract_header)
    end
  end
end
