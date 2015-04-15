require 'minitest/spec'
require 'minitest/autorun'
require 'json-schema'

describe '#single_vault.json' do
  it 'validates against the schema' do
    data = File.read('single_vault.json')
    validation_result = JSON::Validator.validate('schemas/schema.json', data, :validate_schema => true )
    validation_result.must_equal(true)
  end
end
