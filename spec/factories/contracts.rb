FactoryGirl.define do
  factory :contract, class: VaultTree::Contract do

    after(:create) do |contract|
      contract.header = FactoryGirl.build(:header)
      contract.save!
    end

    after(:create) do |contract|
      contract.parties << FactoryGirl.build(:party)
      contract.parties  << FactoryGirl.build(:party)
      contract.save!
    end

    after(:create) do |contract|
      contract.vaults << FactoryGirl.build(:vault)
      contract.vaults << FactoryGirl.build(:vault)
      contract.vaults << FactoryGirl.build(:vault)
      contract.save!
    end

    after(:create) do |contract|
      contract.signature_blocks << FactoryGirl.build(:signature_block)
      contract.signature_blocks << FactoryGirl.build(:signature_block)
      contract.save!
    end
  end

  factory :contract_with_bob, parent: :contract do |contract|
    after(:create) do |contract|
      contract.parties  << FactoryGirl.create(:party_bob)
    end
  end

  factory :contract_with_bob_vk, parent: :bob do |contract|
    after(:create) do |contract|
      contract.parties << FactoryGirl.create(:bob_with_vk)
      contract.save!
    end
  end

end
