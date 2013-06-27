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

    after(:create) do |contract|
      contract.signature_blocks << FactoryGirl.create(:signature_block_bob)
    end
  end

  factory :contract_with_bob_vk, parent: :contract do |contract|
    after(:create) do |contract|
      contract.parties << FactoryGirl.create(:party_bob_with_vk)
    end

    after(:create) do |contract|
      contract.signature_blocks << FactoryGirl.create(:signature_block_bob)
    end
  end

  factory :contract_with_bob_cck, parent: :contract do |contract|
    after(:create) do |contract|
      contract.parties << FactoryGirl.create(:party_bob_with_cck)
    end

    after(:create) do |contract|
      contract.signature_blocks << FactoryGirl.create(:signature_block_bob)
    end
  end

  factory :contract_with_empty_vault, parent: :contract do |contract|
    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:vault, label: '[1]')
    end
  end

  factory :contract_with_filled_vault, parent: :contract do |contract|
    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:vault, label: '[1]', content: 'CONGRATULATIONS YOU HAVE FILLED THE VAULT.')
    end
  end

  factory :contract_with_locked_vault, parent: :contract do |contract|
    after(:create) do |contract|
      contract.vaults << FactoryGirl.create(:locked_vault)
    end
  end
end
