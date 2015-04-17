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

symetric_key_vault = %Q{
  {
    "header": {},
    "vaults": {
      "random_vault_key":{
        "description":"Random Number",
        "contents": "RANDOM_KEY",
        "lock_key": "UNLOCKED",
        "unlock_key": "UNLOCKED",
        "ciphertext": ""
        },
      "message":{
        "description": "Simple Congratulations Message",
        "contents": "EXTERNAL_INPUT['msg']",
        "lock_key": "KEY['random_vault_key']",
        "unlock_key": "KEY['random_vault_key']",
        "ciphertext": ""
      }
    }
  }
}

describe 'symetric key vault' do
  it 'validates against the schema' do
    validation_result = JSON::Validator.validate('schemas/schema.json', symetric_key_vault, :validate_schema => true, strict: true )
    validation_result.must_equal(true)
  end
end
