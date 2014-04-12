module VaultTree
  class ExternalData < Keyword

    def evaluate
      check_for_external_data
      contract.external_data(id)
    end

    def id
      vault.id
    end

    private

    def check_for_external_data
      raise(Exceptions::MissingExternalData.new(nil, vault_id: id)) if missing_external_data?
    end

    def missing_external_data?
      nil_external_data? || empty_external_data?
    end

    def nil_external_data?
      contract.external_data_hash.nil?
    end

    def empty_external_data?
      contract.external_data_hash.empty?
    end

  end
end
