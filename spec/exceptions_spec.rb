require 'minitest/spec'
require 'minitest/unit'
require 'minitest/autorun'
require 'json-schema'
require_relative '../lib/vault-tree'

# The library trys to anticipate common usage errors.
# An error with a helpful message should be raised if there is a problem
# with your vault collection.
#
# If you do run across an unexpected ruby runtime error, please file a Github
# issue. I want to make the experience of executing and debugging your own
# contracts as painless as possible.
#
# Thanks!


describe 'Exceptions' do
  describe 'vault does not exist' do
    before do
      @broken_collection = %Q{
      {
        "vaults": {

          "empty_vault":{
            "contents":   {"random_key": "sym_key"},
            "lock_key":   {"sym_key": { "open_key": "sym_key" }},
            "unlock_key": {"sym_key": { "open_key": "sym_key" }},
            "ciphertext": ""
          }
        }
      }
      }
    end

    it 'validates against the JSON Schema' do
      validation_result = JSON::Validator.validate('schemas/schema.json', @broken_collection, :validate_schema => true, strict: true )
      validation_result.must_equal(true)
    end

    it 'throws the proper runtime exception on closing' do
      json_collection = @broken_collection # defined below
      proc { VaultTree::VaultCollection.new(json_collection).close_vault('DOES_NOT_EXIST') }.must_raise(VaultMissingError)
    end

    it 'throws the proper runtime exception on opening' do
      json_collection = @broken_collection # defined below
      json_collection = VaultTree::VaultCollection.new(json_collection).close_vault('empty_vault')
      proc { VaultTree::VaultCollection.new(json_collection).open_vault('DOES_NOT_EXIST') }.must_raise(VaultMissingError)
    end
  end

  describe 'missing external input' do
    before do
      @ek = 'ef371724fce9e063e061c0cd81174a040a4701572747273ae18dbc4a57a8b605'
      @broken_collection = %Q{
      {
        "vaults": {

          "r":{
            "contents":   {"random_key": "sym_key"},
            "lock_key":   {"sym_key": { "external_input": "ek" }},
            "unlock_key": {"sym_key": { "external_input": "ek" }},
            "ciphertext": ""
          }
        }
      }
      }
    end

    it 'validates against the JSON Schema' do
      validation_result = JSON::Validator.validate('schemas/schema.json', @broken_collection, :validate_schema => true, strict: true )
      validation_result.must_equal(true)
    end

    it 'throws the proper runtime exception on closing' do
      json_collection = @broken_collection # defined below
      proc { VaultTree::VaultCollection.new(json_collection).close_vault('r') }.must_raise(MissingExternalInputError)
    end

    it 'throws the proper runtime exception on opening' do
      json_collection = @broken_collection # defined below
      json_collection = VaultTree::VaultCollection.new(json_collection).close_vault('r', ek: @ek)
      proc { VaultTree::VaultCollection.new(json_collection).open_vault('r') }.must_raise(MissingExternalInputError)
    end
  end
end
