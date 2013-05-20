FactoryGirl.define do
  factory :unlocking_certificate, class: VaultTree::UnlockingCertificate do
    content {"CONTENT-#{generate(:random_hex)}"}
  end
end
