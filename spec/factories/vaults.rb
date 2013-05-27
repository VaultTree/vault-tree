FactoryGirl.define do
  factory :vault, class: VaultTree::Vault do
    label {FactoryHelpers.vault_label}
    custodian_number {FactoryHelpers.random_int} 
    custodian_signature ""
    unlocking_certificate ""
    content_certificate ""
    content ""
    desc ""
  end
end
