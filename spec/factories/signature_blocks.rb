FactoryGirl.define do
  factory :signature_block, class: VaultTree::SignatureBlock do
    party_label "ALICE_#{FactoryHelpers.random_int}"
    signed_label ""
    signed_address ""
    signed_verification_key ""
    signed_public_encryption_key ""
    signed_contract_consent_key ""
  end

  factory :signature_block_bob, parent: :signature_block do
    party_label "BOB"
  end
end
