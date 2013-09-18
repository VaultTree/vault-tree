FactoryGirl.define do
  factory :blank_one_two_three, class: VaultTree::Contract do
    initialize_with { new(File.open(VaultTree::PathHelpers.one_two_three).read)}
  end

  factory :broken_contract, class: VaultTree::Contract do
    initialize_with { new(File.open(VaultTree::PathHelpers.broken_contract).read)}
  end
end
