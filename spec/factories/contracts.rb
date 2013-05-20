FactoryGirl.define do
  factory :dummy_contract, class: VaultTree::Contract do
    after(:create) do |contract|
      contract.nodes << FactoryGirl.create(:node)
      contract.nodes << FactoryGirl.create(:node)
      contract.nodes << FactoryGirl.create(:node)
      contract.contract_header = FactoryGirl.create(:contract_header)
    end
  end

  factory :one_two_three, class: VaultTree::Contract do
    name :one_two_three
    content 'my content'
    after(:create) do |contract|
      contract.nodes << FactoryGirl.create(:node_one)
      contract.nodes << FactoryGirl.create(:node_two)
      contract.nodes << FactoryGirl.create(:node_three)
    end
  end
end
