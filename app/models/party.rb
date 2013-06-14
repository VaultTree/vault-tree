module VaultTree
  class Party < ActiveRecord::Base
    belongs_to :contract
    scope :with_label, lambda { |label| where(:label => label) }

    def set_label(label)
      @label = label
    end

    def set_verification_key(vk)
      @verification_key = vk
    end

    def set_public_encryption_key(pek)
      @public_encryption_key = pek
    end

  end
end
