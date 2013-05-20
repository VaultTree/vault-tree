class VaultSerializer < ActiveModel::Serializer
  attributes :content
  has_many :unlocking_conditions
end
