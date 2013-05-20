class UnlockingConditionSerializer < ActiveModel::Serializer
  attributes :content
  has_one :unlocking_certificate
end
