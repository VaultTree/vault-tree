module VaultTree
  class Contract < ActiveRecord::Base
    has_one :header
    has_many :vaults
    has_many :parties
    has_many :signature_blocks

    def active_model_serializer
      ContractSerializer
    end

    def as_json
      active_model_serializer.new(self).to_json
    end

    def party_attribute(opts)
      p = parties.with_label(opts[:party_label]).first
      p.attributes[opts[:attribute].to_s]
    end

    def party_attribute_signature(opts)
      sig_block = signature_blocks.with_party_label(opts[:party_label]).first
      sig_block.signature_for_attribute(opts[:attribute])
    end

    def set_party_attribute(party_label, attribute, value)
      p = parties.with_label(party_label).first
      p.set_attribute(attribute,value)
    end

    def set_verification_key(vk,pl)
      p = parties.with_label(pl).first
      p.verification_key = vk
      p.save!
    end

    def sign_party_attribute(attr,pl,psk)
      attr_value = parties.with_label(pl).first.send(attr)   
      sig_block = signature_blocks.with_party_label(pl).first
      sig_block.sign_party_attribute(attr, attr_value, psk)
    end

    def sign_verification_key(psk,pl)
      vk = verification_key(pl)
      sig_block = signature_blocks.with_party_label(pl).first
      sig_block.sign_verification_key(vk,psk)
    end

    def verification_key(pl)
      party_with_label(pl).verification_key
    end

    def party_with_label(label)
      @party_with_label ||= self.parties.where(label: label).first
    end

    def fill_vault_with_label(opts = {})
      vaults.with_label(opts[:vault_label]).first.fill(opts[:content])
    end

    def lock_vault_with_label(opts = {})
      vaults.with_label(opts[:vault_label]).first.lock(opts[:vault_key])
    end

    def sign_vault_with_label(opts = {})
      vaults.with_label(opts[:vault_label]).first.sign(opts[:custodian_signing_key])
    end
  end

  class Contract < ActiveRecord::Base
    def self.import(json)
      ContractDeserializer.new().build_contract(json)
    end
  end

  class NullContract
    attr_reader :msg
    def initialize(msg)
      @msg = msg 
    end
    def as_json
      %Q[{"Error":"#{msg}"}]
    end
  end
end
