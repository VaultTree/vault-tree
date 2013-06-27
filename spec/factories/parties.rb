FactoryGirl.define do
  factory :party, class: VaultTree::Party do
    label "ALICE_#{FactoryHelpers.random_int}"
    address ""
    verification_key ""
    public_encryption_key ""
    contract_consent_key ""
  end

  factory :party_bob, parent: :party do
    label "BOB"
  end

  factory :party_bob_with_vk, parent: :party do
    label "BOB"
    verification_key "TEST_VERIFICATION_KEY"
  end

  factory :party_bob_with_cck, parent: :party do
    label "BOB"
    verification_key "TEST_CONTRACT_CONSENT_KEY"
  end
end
