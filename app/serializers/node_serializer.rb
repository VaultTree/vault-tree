class NodeSerializer < ActiveModel::Serializer
  attributes :label
  has_one :vault
end
