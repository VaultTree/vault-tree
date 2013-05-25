FactoryGirl.define do
  factory :vault, class: VaultTree::Vault do
    label {FactoryHelpers.vault_label}
    unlocking_certificate ""
    custodian_signature ""
    desc ""
    content ""
  end
end
