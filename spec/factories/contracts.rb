FactoryGirl.define do
  factory :blank_one_two_three, class: VaultTree::V3::Contract do
    initialize_with { new(File.open(VaultTree::PathHelpers.reference_contract).read)}
  end

  factory :broken_contract, class: VaultTree::V3::Contract do
    initialize_with { new(File.open(VaultTree::PathHelpers.broken_contract).read)}
  end
end
