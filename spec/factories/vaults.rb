FactoryGirl.define do

  factory :vault, class: VaultTree::Vault do
    content {"ENCRYPTED_CONTENT-#{generate(:random_hex)}"}
  end

  factory :genesis_vault, class: VaultTree::GenesisVault do
    content "ENCRYPTED_CONTENT-random_hex"
  end
end
