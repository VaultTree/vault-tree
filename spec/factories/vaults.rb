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
end
