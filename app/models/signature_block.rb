module VaultTree
  class SignatureBlock < ActiveRecord::Base
    belongs_to :contract
    scope :with_party_label, lambda { |party_label| where(:party_label => party_label) }

    def sign_party_attribute(attr, attr_value,psk)
      sig = generate_digital_signature(attr_value,psk)
      write_attribute("signed_#{attr}",sig)
      self.save!
    end

    def sign_verification_key(vk,psk)
      self.signed_verification_key = generate_digital_signature(vk,psk)
      self.save!
    end

    def signature_for_attribute(attr)
      self.send("signed_#{attr}")
    end

    private

    def generate_digital_signature(msg,psk)
      LockSmith::DigitalSignature.new(message: msg, signing_key: psk).generate
    end
  end
end
