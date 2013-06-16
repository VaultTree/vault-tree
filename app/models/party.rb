module VaultTree
  class Party < ActiveRecord::Base
    belongs_to :contract
    scope :with_label, lambda { |label| where(:label => label) }

    def set_attribute(attribute,value)
      write_attribute(attribute, value)
      self.save!
    end
  end
end
