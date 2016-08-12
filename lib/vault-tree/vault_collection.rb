require 'json'
require 'json-schema'
require_relative 'collection'
require_relative 'collection_builder'

module VaultTree
  class VaultCollection
    def initialize(j)
      @json_collection = valid_json(j)
    end
    attr_reader :json_collection

    def open_vault(id, external_input = {data: nil})
      c = collection_builder.combined_collection(vaults_hash, external_input)
      collection.open_vault(id, c)
    end

    def close_vault(id, external_input = {data: nil})
      c = collection_builder.combined_collection(vaults_hash, external_input)
      r = collection.close_vault(id, c)
      JSON.pretty_generate({'vaults' => r['vaults']})
    end

    def valid_json(j)
      JSON::Validator.validate!(schema_file, j, :validate_schema => true, strict: true)
      return j
    end

    def vaults_hash
      JSON.parse(json_collection)['vaults']
    end

    def collection
      VaultTree::Collection.new
    end

    def collection_builder
      VaultTree::CollectionBuilder.new
    end

    def schema_file
      'schemas/schema.json'
    end
  end
end
