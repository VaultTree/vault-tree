class ContractSerializer < ActiveModel::Serializer
  has_one :contract_header
  has_many :vaults
end
