module VaultTree
  class Contract < ActiveRecord::Base
    has_many :vaults
    has_many :parties

    def as_json
      ContractSerializer.new(presenter).to_json
    end

    private

    def presenter
      ContractPresenter.new(self)
    end
  end
end
