FactoryGirl.define do
  factory :node, class: VaultTree::Node do
    label {"NODE_LABEL-#{generate(:random_hex)}"}
    content {"NODE_CONTENT-#{generate(:random_hex)}"}
    after(:create) do |node|
      node.vault = FactoryGirl.create(:vault)
    end
  end
end
