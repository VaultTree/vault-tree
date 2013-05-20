class ContractSerializer < ActiveModel::Serializer
  attributes :name
  has_many :nodes
end
