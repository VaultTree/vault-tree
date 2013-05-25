FactoryGirl.define do
  factory :party, class: VaultTree::Party do
    number {FactoryHelpers.random_int}
    public_key ""
    address ""
    affirmation_key ""
    contract_signature ""
  end
end
