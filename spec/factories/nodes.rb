FactoryGirl.define do
  factory :node, class: VaultTree::Node do
    label {"NODE_LABEL-#{generate(:random_hex)}"}
    content {"NODE_CONTENT-#{generate(:random_hex)}"}
    after(:create) do |node|
      node.vault = FactoryGirl.create(:vault)
    end
  end

  factory :node_one, parent: :node  do
    label {"[1]"}
  end

  factory :node_two, parent: :node do
    label {"[1,2]"}
  end

  factory :node_three, parent: :node do
    label {"[1,2,3]"}
  end
end
