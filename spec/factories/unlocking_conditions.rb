FactoryGirl.define do
  factory :unlocking_condition, class: VaultTree::UnlockingCondition do
    content {"CONTENT-#{generate(:random_hex)}"}
    after(:create) do |unlocking_condition|
      unlocking_condition.unlocking_certificate = FactoryGirl.create(:unlocking_certificate)
    end
  end
end
