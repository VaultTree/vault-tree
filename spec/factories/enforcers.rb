FactoryGirl.define do
  factory :dummy_enforcer, class: VaultTree::Enforcer do
    after(:create) do |enforcer|
      enforcer.contract = FactoryGirl.create(:dummy_contract)
      enforcer.symmetric_vaults << FactoryGirl.create(:dummy_symmetric_vault)
      enforcer.symmetric_vaults << FactoryGirl.create(:dummy_symmetric_vault)
      enforcer.asymmetric_vaults << FactoryGirl.create(:dummy_asymmetric_vault)
      enforcer.asymmetric_vaults << FactoryGirl.create(:dummy_asymmetric_vault)
    end
  end
end
