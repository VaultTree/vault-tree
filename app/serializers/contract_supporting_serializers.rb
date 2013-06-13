module VaultTree
  class ContractSerializer < ActiveModel::Serializer
    has_one :header
    has_many :parties
    has_many :vaults
    has_many :signature_blocks
  end

  class HeaderSerializer < ActiveModel::Serializer
    attribute :checksum
    attribute :specification
  end

  class PartySerializer < ActiveModel::Serializer
    attribute :label
    attribute :address
    attribute :verification_key
    attribute :public_encryption_key
    attribute :contract_consent_key
  end

  class VaultSerializer < ActiveModel::Serializer
    attribute :label
    attribute :custodian
    attribute :unlocking_certificate
    attribute :content_certificate
    attribute :content
    attribute :signed_vault_content
    attribute :desc
  end

  class SignatureBlockSerializer < ActiveModel::Serializer
    attribute :party_label
    attribute :signed_label
    attribute :signed_address
    attribute :signed_verification_key
    attribute :signed_public_encryption_key
    attribute :signed_contract_consent_key
  end
end
