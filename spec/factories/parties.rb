FactoryGirl.define do
  factory :party, class: VaultTree::Party do
    number {FactoryHelpers.random_int}
    public_key ""
    address ""
    affirmation_key ""
    contract_signature ""
    after(:create) do |party|
      party.vaults << FactoryGirl.create(:vault)
      party.vaults << FactoryGirl.create(:vault)
      party.vaults << FactoryGirl.create(:vault)
    end
  end
end
