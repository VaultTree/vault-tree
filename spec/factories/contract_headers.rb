FactoryGirl.define do
  factory :contract_header, class: VaultTree::ContractHeader do
    content "HEADER_CONTENT"
  end

  factory :dummy_contract_header, class: VaultTree::ContractHeader do
    contract_vault_id "UUID_25"
    content "HEADER_CONTENT"
  end
end
