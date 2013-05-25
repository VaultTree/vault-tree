FactoryGirl.define do
  factory :contract_header, class: VaultTree::ContractHeader do
    content "HEADER_CONTENT"
  end

  factory :dummy_contract_header, class: VaultTree::ContractHeader do
    content "HEADER_CONTENT"
  end
end
