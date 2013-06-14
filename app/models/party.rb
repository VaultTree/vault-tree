module VaultTree
  class Party < ActiveRecord::Base
    belongs_to :contract
    scope :with_label, lambda { |label| where(:label => label) }

  end
end
