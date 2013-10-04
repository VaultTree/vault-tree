FactoryGirl.define do
  factory :reference_contract, class: VaultTree::Contract do
    initialize_with { new(File.open(VaultTree::PathHelpers.reference_contract).read)}
  end

  factory :broken_contract, class: VaultTree::Contract do
    initialize_with { new(File.open(VaultTree::PathHelpers.broken_contract).read)}
  end
end
