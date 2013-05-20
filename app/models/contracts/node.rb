module VaultTree
  class Node < ActiveRecord::Base
    belongs_to :contract
    has_one :vault

    def active_model_serializer
      NodeSerializer
    end

    def as_json
      active_model_serializer.new(self).to_json
    end

  end
end
