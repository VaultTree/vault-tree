FactoryGirl.define do
  factory :contract, class: VaultTree::Contract do

    after(:create) do |contract|
      contract.header = FactoryGirl.create(:header)
      contract.save!
    end

    after(:create) do |contract|
      contract.parties << FactoryGirl.build(:party)
      contract.parties  << FactoryGirl.build(:party)
      contract.parties  << FactoryGirl.build(:party, label: "BOB")
      contract.save!
    end

    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.vaults << FactoryGirl.create(:vault)
      contract.save!
    end

    after(:create) do |contract|
      contract.signature_blocks << FactoryGirl.create(:signature_block)
      contract.signature_blocks << FactoryGirl.create(:signature_block)
      contract.save!
    end
  end
end
