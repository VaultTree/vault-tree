module VaultTree
  class ContractSerializer < ActiveModel::Serializer
    has_one :header
    has_many :parties
    has_many :vaults
    has_many :signature_blocks
  end

  class HeaderSerializer < ActiveModel::Serializer
    attributes :checksum, :specification
  end

  class PartySerializer < ActiveModel::Serializer
    attributes :number, :address, :signature_key, :encryption_key
  end

  class VaultSerializer < ActiveModel::Serializer
    attributes :label, :custodian_number, :custodian_signature, :unlocking_certificate, :content_certificate, :content, :desc
  end

  class SignatureBlockSerializer < ActiveModel::Serializer
    attributes :party_number, :affirmation_key, :signature
  end
end
