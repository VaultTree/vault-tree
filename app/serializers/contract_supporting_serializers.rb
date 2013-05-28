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
    attributes :label, :address, :verification_key, :public_encryption_key, :contract_consent_key
  end

  class VaultSerializer < ActiveModel::Serializer
    attributes :label, :custodian, :unlocking_certificate, :content_certificate, :content, :signed_vault_content, :desc
  end

  class SignatureBlockSerializer < ActiveModel::Serializer
    attributes :party_label, :signed_label, :signed_address, :signed_verification_key, :signed_public_encryption_key, :signed_contract_consent_key
  end
end
