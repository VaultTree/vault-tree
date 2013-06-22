FactoryGirl.define do
  factory :vault, class: VaultTree::Vault do
    label {FactoryHelpers.vault_label}
    custodian ""
    unlocking_certificate ""
    content_certificate ""
    content ""
    signed_vault_content ""
    desc ""
  end

  factory :locked_vault, parent: :vault do
    label "[1]"
    content "ENCRYPTED_CONTENT"
    signed_vault_content ""
  end
end
