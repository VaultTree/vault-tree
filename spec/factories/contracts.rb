FactoryGirl.define do
  factory :contract, class: VaultTree::Contract do

    after(:create) do |contract|
      contract.header = FactoryGirl.create(:header)
    end

    after(:create) do |contract|
      contract.parties << FactoryGirl.create(:party)
      contract.parties  << FactoryGirl.create(:party)
      contract.parties  << FactoryGirl.create(:party, label: "BOB")
    end

    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
    end

    after(:create) do |contract|
      contract.signature_blocks << FactoryGirl.create(:signature_block)
      contract.signature_blocks << FactoryGirl.create(:signature_block)
    end
  end
end
