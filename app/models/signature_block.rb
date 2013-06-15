module VaultTree
  class SignatureBlock < ActiveRecord::Base
    belongs_to :contract
    scope :with_party_label, lambda { |party_label| where(:party_label => party_label) }


    def sign_verification_key(vk,psk)
      self.signed_verification_key = generate_digital_signature(vk,psk)
      self.save!
    end

    private

    def generate_digital_signature(msg,psk)
      LockSmith::DigitalSignature.new(message: msg, signing_key: psk).generate
    end
  end
end
