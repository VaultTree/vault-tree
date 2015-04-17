require 'minitest/spec'
require 'minitest/autorun'
require 'json-schema'

single_vault = %Q{
  {
    "vaults":{
      "vault_id":{
        "contents": {"vault_collection": ["id_one","id_two"]},
        "lock_key": {
          "asym_pub_key": {"computed_pub_key": {"vault_contents":"id"}},
          "asym_prv_key": {"external_input":""}
        },
        "unlock_key": {
          "sym_key": {"generated_key": "open_asym_prv"}
        },
        "ciphertext": "" }
    }
  }
}

describe '#single_vault.json' do
  it 'validates against the schema' do
    validation_result = JSON::Validator.validate('schemas/schema.json', single_vault, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end
end

symetric_key_vault = %Q[
  {
    "vaults": {
      "random_key": {
        "contents": {
          "generated_key": "random_sym"
        },
        "lock_key": {
          "sym_key": {
            "generated_key": "open_sym"
          }
        },
        "unlock_key": {
          "sym_key": {
            "generated_key": "open_sym"
          }
        },
        "ciphertext": ""
      }
    }
  }
]

describe 'symetric key vault' do
  it 'validates against the schema' do
    validation_result = JSON::Validator.validate!('schemas/schema.json', symetric_key_vault, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end
end

external_input_vault = %Q[
  {
    "vaults": {
      "message":{
        "contents": {"external_input":"msg"},
        "lock_key": {"sym_key":{"external_input":"secret"}},
        "unlock_key": {"sym_key":{"external_input":"secret"}},
        "ciphertext": ""
      }
    }
  }
]

describe 'external input vault ' do
  it 'validates against the schema' do
    validation_result = JSON::Validator.validate!('schemas/schema.json', external_input_vault, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end
end
