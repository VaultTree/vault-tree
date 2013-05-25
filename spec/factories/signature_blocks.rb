FactoryGirl.define do
  factory :signature_block, class: VaultTree::SignatureBlock do
    party_number {FactoryHelpers.random_int}
    affirmation_key ""
    signature ""
  end
end
