FactoryGirl.define do
  factory :party, class: VaultTree::Party do
    number {FactoryHelpers.random_int}
    signature_key ""
    encryption_key ""
    address ""
    affirmation_key ""
  end
end
