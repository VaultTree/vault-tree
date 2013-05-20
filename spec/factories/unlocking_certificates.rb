FactoryGirl.define do
  factory :unlocking_certificate, class: VaultTree::UnlockingCertificate do
    content {"UNLOCKING_CERTIFICATE_CONTENT-#{generate(:random_hex)}"}
  end
end
