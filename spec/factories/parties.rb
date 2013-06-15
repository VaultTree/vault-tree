FactoryGirl.define do
  factory :party, class: VaultTree::Party do
    contract_id 1
    label "ALICE_#{FactoryHelpers.random_int}"
    address ""
    verification_key ""
    public_encryption_key ""
    contract_consent_key ""
  end

  factory :bob, parent: :party do
    label "BOB"
  end

  factory :bob_with_vk, parent: :bob do
    verification_key "TEST_VERIFICATION_KEY"
  end
end
