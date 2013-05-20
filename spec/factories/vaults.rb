FactoryGirl.define do

  factory :vault, class: VaultTree::Vault do
    content {"ENCRYPTED_CONTENT-#{generate(:random_hex)}"}
    after(:create) do |vault|
      vault.unlocking_conditions << FactoryGirl.create(:unlocking_condition)
      vault.unlocking_conditions << FactoryGirl.create(:unlocking_condition)
    end
  end

  factory :dummy_vault, class: VaultTree::Vault do
    content {"ENCRYPTED_CONTENT-#{generate(:random_hex)}"}
  end

  factory :dummy_symmetric_vault, class: VaultTree::SymmetricVault do
  end

  factory :dummy_asymmetric_vault, class: VaultTree::AsymmetricVault do
  end
end
