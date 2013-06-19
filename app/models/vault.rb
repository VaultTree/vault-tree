module VaultTree
  class Vault < ActiveRecord::Base
    belongs_to :contract
    belongs_to :party
    scope :with_label, lambda { |label| where(:label => label) }

    def fill(c)
      self.content = c
      save!
    end
  end
end
