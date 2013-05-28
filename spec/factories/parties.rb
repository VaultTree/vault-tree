FactoryGirl.define do
  factory :party, class: VaultTree::Party do
    label "ALICE_#{FactoryHelpers.random_int}"
    address ""
    verification_key ""
    public_encryption_key ""
    contract_consent_key ""
  end
end
