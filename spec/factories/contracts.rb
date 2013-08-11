FactoryGirl.define do
  factory :blank_one_two_three, class: VaultTree::V3::Contract do
    initialize_with { new(File.open(VaultTree::PathHelpers.one_two_three_050).read)}
  end
end
